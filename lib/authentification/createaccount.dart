import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesla/screens.dart';
import 'package:tesla/special_methods.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final List<MaterialColor> listColors = Colors.primaries;
  String? groupValue;
  String? phoneCode;
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController phoneNumberController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  File? imageFile;
  bool choosen = false;
  bool isNotVisible = true;
  late String uid;
  String? mtoken;
  FirebaseMessaging fcmInstance = FirebaseMessaging.instance;
  bool isValidated = false;
  int counter = 0;

  void getToken() async {
    await fcmInstance.getToken().then((value) {
      mtoken = value;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void totalUsers() async {
    await FirebaseFirestore.instance.collection("users").get().then((value) {
      counter = value.docs.length + 1;
    });
  }

  @override
  void initState() {
    totalUsers();
    super.initState();
  }

  void validateForm() async {
    if (imageFile == null) {
      SpecialMethods.displayDialog(
        context: context,
        title: "Image",
        content: "Pick up a picture",
      );
    } else if (groupValue == null) {
      SpecialMethods.displayDialog(
        context: context,
        title: "Gender",
        content: "Choose your gender please",
      );
    } else if (phoneCode == null) {
      SpecialMethods.displayDialog(
        context: context,
        title: "Country",
        content: "Make sure to set up your country",
      );
    }
    bool isValid = formKey.currentState!.validate();
    if (isValid) {
      try {
        setState(() {
          isValidated = true;
        });
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseStorage.instance
            .ref()
            .child(uid)
            .putFile(imageFile!)
            .then(
          (p0) async {
            await Future.delayed(const Duration(seconds: 2));
            getToken();
            await FirebaseFirestore.instance.collection("users").doc(uid).set(
              {
                "uid": uid,
                "username": usernameController.text.trim().toUpperCase(),
                "email": emailController.text.trim().toLowerCase(),
                "phone_number": phoneNumberController.text.trim(),
                "gender": groupValue!,
                "password": passwordController.text.trim(),
                "origin": phoneCode!,
                "creation_date": Timestamp.now(),
                "profile_picture_path": await p0.ref.getDownloadURL(),
                "rank": counter,
                "followers": 0,
                "following": 0,
                "followers_list": [],
                "followings_list": [uid],
                "xp": 0,
                "about": "",
                "token": mtoken,
                "status": "Online",
              },
            );
            for (String i in [
              "regex_matrix",
              "regex_integral",
              "c",
              "python"
            ]) {
              await FirebaseFirestore.instance
                  .collection("quizzes")
                  .doc(FirebaseAuth.instance.currentUser!.uid + i)
                  .set({"currentIndex": 0}, SetOptions(merge: true));
            }
          },
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const Screens(),
          ),
        );
      } catch (exception) {
        setState(() {
          isValidated = false;
        });
        SpecialMethods.displayDialog(
            context: context,
            title: "Error Occured",
            content: exception.toString());
      }
    }
  }

  void takeFromCamera() async {
    try {
      XFile? picture =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (picture != null) cropImage(picture.path);
    } catch (exception) {
      SpecialMethods.displayDialog(
          context: context,
          title: "Error Occured",
          content: exception.toString());
    }
  }

  void takeFromGallery() async {
    try {
      XFile? picture =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picture != null) cropImage(picture.path);
    } catch (exception) {
      SpecialMethods.displayDialog(
          context: context,
          title: "Error Occured",
          content: exception.toString());
    }
  }

  void cropImage(String imagePath) async {
    try {
      CroppedFile? croppedImage =
          await ImageCropper().cropImage(sourcePath: imagePath);
      setState(() {
        imageFile = File(croppedImage!.path);
        choosen = true;
      });
    } catch (exception) {
      SpecialMethods.displayDialog(
          context: context,
          title: "Error Occured",
          content: exception.toString());
    }
    Navigator.pop(context);
  }

  void showTheDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Source",
            style: TextStyle(
              color: Colors.purple,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  takeFromCamera();
                },
                leading: const Icon(
                  Icons.camera,
                  size: 20,
                  color: Colors.blue,
                ),
                title: const Text(
                  "Camera",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  takeFromGallery();
                },
                leading: const Icon(
                  Icons.image,
                  size: 20,
                  color: Colors.blue,
                ),
                title: const Text(
                  "Gallery",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 62, 59, 59),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            FontAwesomeIcons.caretLeft,
            color: Colors.purple,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: CustomPaint(
              size: Size(
                  MediaQuery.of(context).size.width,
                  (MediaQuery.of(context).size.width * 2.2) //1.875
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        showTheDialog();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.purple,
                                radius: 60,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 57,
                                child: imageFile == null
                                    ? Image.asset(
                                        "assets/loginpic.png",
                                        color: Colors.white,
                                      )
                                    : CircleAvatar(
                                        radius: 57,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: FileImage(imageFile!),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SpecialMethods.displayTextFormField(
                    autofocus: false,
                    obscureText: false,
                    maxLines: 1,
                    func: (str) {
                      if (str!.isEmpty) {
                        return "username can't be empty.";
                      } else if (!str.contains(RegExp(r"[a-zA-Z_]\w+"))) {
                        return "username must start with alphabet or undescore ( _ ) and followed\nby alphanumeric characters including underscore.";
                      } else {
                        return null;
                      }
                    },
                    controller: usernameController,
                    focusNode: usernameFocusNode,
                    hintText: "Username",
                    prefixIcon: const Icon(
                      FontAwesomeIcons.userAstronaut,
                      size: 20,
                      color: Colors.purple,
                    ),
                    suffixIcon: null,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SpecialMethods.displayTextFormField(
                    autofocus: false,
                    obscureText: false,
                    maxLines: 1,
                    func: (str) {
                      if (str!.isEmpty) {
                        return "email can't be empty.";
                      } else if (!str.contains(
                          RegExp(r"[a-zA-Z]\w+\@[a-zA-Z]+\.[a-zA-Z]{2,3}"))) {
                        return "email must respect the following pattern : aaa@bbb.ccc";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    focusNode: emailFocusNode,
                    hintText: "E-mail",
                    prefixIcon: const Icon(
                      Icons.mail,
                      size: 20,
                      color: Colors.purple,
                    ),
                    suffixIcon: null,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SpecialMethods.displayTextFormField(
                    autofocus: false,
                    obscureText: false,
                    maxLines: 1,
                    func: (str) {
                      if (str!.isEmpty) {
                        return "phone number cannot be empty.";
                      } else if (!str.contains(RegExp(r"[\d\s]+"))) {
                        return "phone number field must containe digits and may contain whitespaces.";
                      } else {
                        return null;
                      }
                    },
                    controller: phoneNumberController,
                    focusNode: phoneNumberFocusNode,
                    hintText: "Phone Number",
                    prefixIcon: const Icon(
                      FontAwesomeIcons.phone,
                      size: 20,
                      color: Colors.purple,
                    ),
                    suffixIcon: null,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile(
                      tileColor: Colors.white.withOpacity(.1),
                      toggleable: true,
                      activeColor: Colors.purple,
                      title: const Text(
                        "Male",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: "M",
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value as String?;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile(
                      tileColor: Colors.white.withOpacity(.1),
                      toggleable: true,
                      activeColor: Colors.purple,
                      title: const Text(
                        "Female",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: "F",
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value as String?;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SpecialMethods.displayTextFormField(
                    autofocus: false,
                    obscureText: isNotVisible,
                    maxLines: 1,
                    func: (str) {
                      if (str!.isEmpty) {
                        return "password is mandatory.";
                      } else if (str.length < 8) {
                        return "password length must be >= 8";
                      } else if (!str.contains(RegExp(r"[\w\s]+"))) {
                        return "password must be formed with alphanumeric characters,optionally with underscores.";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    hintText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 20,
                      color: Colors.purple,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            isNotVisible = !isNotVisible;
                          },
                        );
                      },
                      icon: Icon(
                        isNotVisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.purple,
                        size: 20,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      color: Colors.white.withOpacity(.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CountryPickerDropdown(
                          dropdownColor: Colors.white.withOpacity(.6),
                          onValuePicked: (Country country) {
                            phoneCode = country.name;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  !isValidated
                      ? ListTile(
                          trailing: IconButton(
                            onPressed: validateForm,
                            icon: const Icon(
                              FontAwesomeIcons.caretRight,
                              color: Colors.purple,
                              size: 30,
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 152, 152, 152)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.4986667);
    path0.cubicTo(
        size.width * 0.0819250,
        size.height * 0.3910133,
        size.width * 0.1800000,
        size.height * 0.4216667,
        size.width * 0.2431250,
        size.height * 0.3926667);
    path0.cubicTo(
        size.width * 0.3851750,
        size.height * 0.3609067,
        size.width * 0.5550000,
        size.height * 0.3593333,
        size.width * 0.6425000,
        size.height * 0.3586667);
    path0.cubicTo(
        size.width * 0.7193750,
        size.height * 0.3536667,
        size.width * 0.7956250,
        size.height * 0.3503333,
        size.width * 0.8700000,
        size.height * 0.3226667);
    path0.quadraticBezierTo(size.width * 0.9025000, size.height * 0.3080000,
        size.width, size.height * 0.2640000);
    path0.lineTo(size.width, size.height * 0.6939067);
    path0.quadraticBezierTo(size.width * 0.8943750, size.height * 0.7146667,
        size.width * 0.7105250, size.height * 0.7848933);
    path0.cubicTo(
        size.width * 0.6215750,
        size.height * 0.8212400,
        size.width * 0.5935500,
        size.height * 0.8433467,
        size.width * 0.5322750,
        size.height * 0.8895600);
    path0.quadraticBezierTo(size.width * 0.4185750, size.height * 0.9950133,
        size.width * 0.4365000, size.height);
    path0.lineTo(0, size.height);
    path0.quadraticBezierTo(
        0, size.height * 0.8746667, 0, size.height * 0.4986667);
    path0.close();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
      ..color = const Color.fromARGB(255, 62, 59, 59)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path1 = Path();
    path1.moveTo(0, 0);
    path1.lineTo(0, size.height * 0.5000000);
    path1.quadraticBezierTo(size.width * 0.0337750, size.height * 0.4315333,
        size.width * 0.3323500, size.height * 0.3903733);
    path1.cubicTo(
        size.width * 0.6396000,
        size.height * 0.3580933,
        size.width * 0.7083750,
        size.height * 0.3610800,
        size.width * 0.8235000,
        size.height * 0.3459600);
    path1.quadraticBezierTo(size.width * 1.0008000, size.height * 0.3207200,
        size.width, size.height * 0.2653333);
    path1.lineTo(size.width, 0);
    path1.lineTo(0, 0);
    path1.close();

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
