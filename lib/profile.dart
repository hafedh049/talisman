import 'dart:io';
import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesla/contactprofile.dart';
import 'package:tesla/error.dart';
import 'package:tesla/periodictable/cte.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void takeFromCamera() async {
    XFile? picture = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picture != null) cropImage(picture.path);
  }

  void takeFromGallery() async {
    XFile? picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picture != null) cropImage(picture.path);
  }

  void cropImage(String imagePath) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imagePath);

    if (croppedImage != null) {
      await FirebaseStorage.instance
          .ref()
          .child(FirebaseAuth.instance.currentUser!.uid)
          .putFile(File(croppedImage.path))
          .then((p0) async => FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({"profile_picture_path": await p0.ref.getDownloadURL()}));
      setState(() {});
      Fluttertoast.showToast(
          msg: "Profile Picture Changed",
          textColor: Colors.white,
          backgroundColor: Colors.amber);
      Navigator.pop(context);
    }
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
              color: Colors.green,
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

  bool bioState = true;
  TextEditingController bioStateController = TextEditingController(text: "");
  bool phoneState = true;
  TextEditingController phoneStateController = TextEditingController(text: "");
  bool countryState = true;
  TextEditingController countryStateController =
      TextEditingController(text: "");
  TextEditingController passwordStateController =
      TextEditingController(text: "");
  TextEditingController emailStateController = TextEditingController(text: "");
  bool visible = false;
  bool emailState = true;
  bool passwordState = true;

  @override
  void dispose() {
    super.dispose();
    bioStateController.dispose();
    phoneStateController.dispose();
    countryStateController.dispose();
    emailStateController.dispose();
    passwordStateController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            Container(
              color: Colors.transparent,
              height: 450,
              child: CustomPaint(
                size: Size(
                    MediaQuery.of(context).size.width,
                    (MediaQuery.of(context).size.width * 0.62)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: "long-press to change it",
                                      textColor: Colors.white,
                                      backgroundColor: Colors.blueGrey);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 16, sigmaY: 16),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InteractiveViewer(
                                            child: CachedNetworkImage(
                                              fadeInDuration: const Duration(
                                                  milliseconds: 300),
                                              progressIndicatorBuilder:
                                                  (context, url, progress) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.green,
                                                  ),
                                                );
                                              },
                                              imageUrl: snapshot.data!
                                                  .get("profile_picture_path"),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                onLongPress: showTheDialog,
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 217, 255),
                                      radius: 80,
                                    ),
                                    ClipRRect(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 78,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          snapshot.data!
                                              .get("profile_picture_path"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                snapshot.data!.get("username"),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.blueAccent.withOpacity(.2),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Badge(
                                      badgeContent: Text(
                                        snapshot.data!
                                            .get("followers")
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 4,
                                                  sigmaY: 4,
                                                ),
                                                child: AlertDialog(
                                                  backgroundColor: primaryColor,
                                                  content: Container(
                                                    height: 200,
                                                    child: StreamBuilder<
                                                        QuerySnapshot<
                                                            Map<String,
                                                                dynamic>>>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection("users")
                                                          .where("uid",
                                                              isNotEqualTo:
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                          .where(
                                                              "followings_list",
                                                              arrayContains:
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          if (snapshot
                                                              .data!
                                                              .docs
                                                              .isNotEmpty) {
                                                            return Center(
                                                              child: ListView
                                                                  .builder(
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Card(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .2),
                                                                    child:
                                                                        ListTile(
                                                                      onTap:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (BuildContext context) =>
                                                                                ContactProfile(
                                                                              username: snapshot.data!.docs[index].get("username"),
                                                                              followers: snapshot.data!.docs[index].get("followers"),
                                                                              following: snapshot.data!.docs[index].get("following"),
                                                                              xp: snapshot.data!.docs[index].get("xp"),
                                                                              rank: snapshot.data!.docs[index].get("rank"),
                                                                              email: snapshot.data!.docs[index].get("email"),
                                                                              country: snapshot.data!.docs[index].get("origin"),
                                                                              phoneNumber: snapshot.data!.docs[index].get("phone_number"),
                                                                              profilePicturePath: snapshot.data!.docs[index].get("profile_picture_path"),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      subtitle:
                                                                          Text(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .get("about"),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      leading:
                                                                          CircleAvatar(
                                                                        backgroundImage:
                                                                            CachedNetworkImageProvider(
                                                                          snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .get("profile_picture_path"),
                                                                        ),
                                                                        radius:
                                                                            20,
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .get("username"),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          } else {
                                                            return const Center(
                                                              child: Text(
                                                                "No followers",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            );
                                                          }
                                                        } else if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors
                                                                  .pinkAccent,
                                                            ),
                                                          );
                                                        } else {
                                                          return Error(
                                                              error: snapshot
                                                                  .error
                                                                  .toString());
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: Image.asset(
                                          "assets/followers.png",
                                          color: Colors.white,
                                        ),
                                        highlightColor: Colors.transparent,
                                      ),
                                    ),
                                    Badge(
                                      badgeContent: Text(
                                        snapshot.data!
                                            .get("following")
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          List? followings;
                                          await FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .get()
                                              .then((value) => followings =
                                                  value.get("followings_list"));
                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 4,
                                                  sigmaY: 4,
                                                ),
                                                child: AlertDialog(
                                                  backgroundColor: primaryColor,
                                                  content: Container(
                                                    height: 200,
                                                    child: StreamBuilder<
                                                        QuerySnapshot<
                                                            Map<String,
                                                                dynamic>>>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection("users")
                                                          .where("uid",
                                                              whereIn:
                                                                  followings)
                                                          .where("uid",
                                                              isNotEqualTo:
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          if (snapshot
                                                              .data!
                                                              .docs
                                                              .isNotEmpty) {
                                                            return Center(
                                                              child: ListView
                                                                  .builder(
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Card(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .2),
                                                                    child:
                                                                        ListTile(
                                                                      onTap:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (BuildContext context) =>
                                                                                ContactProfile(
                                                                              username: snapshot.data!.docs[index].get("username"),
                                                                              followers: snapshot.data!.docs[index].get("followers"),
                                                                              following: snapshot.data!.docs[index].get("following"),
                                                                              xp: snapshot.data!.docs[index].get("xp"),
                                                                              rank: snapshot.data!.docs[index].get("rank"),
                                                                              email: snapshot.data!.docs[index].get("email"),
                                                                              country: snapshot.data!.docs[index].get("origin"),
                                                                              phoneNumber: snapshot.data!.docs[index].get("phone_number"),
                                                                              profilePicturePath: snapshot.data!.docs[index].get("profile_picture_path"),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      subtitle:
                                                                          Text(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .get("about"),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      leading:
                                                                          CircleAvatar(
                                                                        backgroundImage:
                                                                            CachedNetworkImageProvider(
                                                                          snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .get("profile_picture_path"),
                                                                        ),
                                                                        radius:
                                                                            20,
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .get("username"),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          } else {
                                                            return const Center(
                                                              child: Text(
                                                                "You are following none.",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            );
                                                          }
                                                        } else if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors
                                                                  .pinkAccent,
                                                            ),
                                                          );
                                                        } else {
                                                          return Error(
                                                              error: snapshot
                                                                  .error
                                                                  .toString());
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: Image.asset(
                                          "assets/following.png",
                                          color: Colors.white,
                                        ),
                                        highlightColor: Colors.transparent,
                                      ),
                                    ),
                                    Badge(
                                      badgeContent: Text(
                                        snapshot.data!.get("xp").toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                      child: const IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          FontAwesomeIcons.cloudsmith,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Badge(
                                      badgeContent: Text(
                                        snapshot.data!.get("rank").toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                      child: const IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          FontAwesomeIcons.rankingStar,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              onTap: null,
                              leading: const Icon(
                                FontAwesomeIcons.bookAtlas,
                                color: Colors.white,
                              ),
                              title: const Text(
                                "Bio",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: AnimatedCrossFade(
                                  firstChild: Text(
                                    snapshot.data!.get("about").isEmpty
                                        ? "No Bio"
                                        : snapshot.data!.get("about"),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  secondChild: TextFormField(
                                    keyboardType: TextInputType.text,
                                    autofocus: true,
                                    controller: bioStateController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        hintText: "Type...",
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                  crossFadeState: bioState
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 100)),
                              trailing: AnimatedCrossFade(
                                  firstChild: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        bioState = !bioState;
                                      });
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.pencil,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  secondChild: IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        "about": bioStateController.text.trim()
                                      });
                                      bioStateController.clear();

                                      setState(() {
                                        bioState = !bioState;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  crossFadeState: bioState
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 100)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              onTap: null,
                              leading: const Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.white,
                              ),
                              title: const Text(
                                "E-mail",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: AnimatedCrossFade(
                                  firstChild: Text(
                                    snapshot.data!.get("email"),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  secondChild: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: true,
                                    controller: emailStateController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        hintText: "Type...",
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                  crossFadeState: emailState
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 100)),
                              trailing: AnimatedCrossFade(
                                  firstChild: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        emailState = !emailState;
                                      });
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.pencil,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  secondChild: IconButton(
                                    onPressed: () async {
                                      if (emailStateController.text.contains(
                                          RegExp(
                                              r"^(?=[a-z]\w+\@.+\..+).+$"))) {
                                        FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email:
                                                    snapshot.data!.get("email"),
                                                password: snapshot.data!
                                                    .get("password"))
                                            .then((value) => value.user!
                                                    .updateEmail(
                                                        emailStateController
                                                            .text
                                                            .trim())
                                                    .then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection("users")
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .update({
                                                    "email":
                                                        emailStateController
                                                            .text
                                                            .trim()
                                                  });
                                                  Fluttertoast.showToast(
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      msg: "E-mail updated",
                                                      textColor: Colors.white,
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255, 0, 174, 61));
                                                  emailStateController.clear();
                                                }));
                                      } else {
                                        Fluttertoast.showToast(
                                            toastLength: Toast.LENGTH_LONG,
                                            msg:
                                                "E-mail field should be in form of x@y.z",
                                            textColor: Colors.white,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 0, 174, 61));
                                      }
                                      setState(() {
                                        emailState = !emailState;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  crossFadeState: emailState
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 100)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              onTap: () {
                                setState(() {
                                  visible = !visible;
                                });
                              },
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              leading: const Icon(
                                FontAwesomeIcons.key,
                                color: Colors.white,
                              ),
                              title: const Text(
                                "Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: /*AnimatedCrossFade(
                                  firstChild:*/
                                  Text(
                                visible
                                    ? snapshot.data!.get("password")
                                    : snapshot.data!
                                        .get("password")
                                        .split("")
                                        .map((c) => "*")
                                        .toList()
                                        .join(""),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              /* secondChild: TextFormField(
                                    autofocus: true,
                                    obscureText: visible,
                                    controller: passwordStateController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                        hintText: "Type...",
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                  ),
                                  crossFadeState: passwordState
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 100)),
                              trailing: AnimatedCrossFade(
                                  firstChild: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordState = !passwordState;
                                      });
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.pencil,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  secondChild: IconButton(
                                    onPressed: () async {
                                      if (passwordStateController.text.contains(
                                          RegExp(
                                              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.{8,})\w+$"))) {
                                        //Create an instance of the current user.
                                        var user =
                                            FirebaseAuth.instance.currentUser!;
                                        //Must re-authenticate user before updating the password. Otherwise it may fail or user get signed out.

                                        final cred = EmailAuthProvider.credential(
                                            email: user.email!,
                                            password: /*snapshot.data!
                                                    .get("password")*/
                                                "1234567890");
                                        await user
                                            .reauthenticateWithCredential(cred)
                                            .then((value) async {
                                          await user
                                              .updatePassword(
                                                  passwordStateController.text
                                                      .trim())
                                              .then((_) async {
                                            await FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .update({
                                              "password":
                                                  passwordStateController.text
                                                      .trim()
                                            });
                                            Fluttertoast.showToast(
                                                toastLength: Toast.LENGTH_LONG,
                                                msg: "Password changed",
                                                textColor: Colors.white,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 230, 0, 255));

                                            passwordStateController.clear();
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        }).catchError((err) {
                                          print(err.toString() + "1111");
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                            toastLength: Toast.LENGTH_LONG,
                                            msg:
                                                "Password must contain alphanumeric (lower and upper case letters with digits) characters and it's length >= 8",
                                            textColor: Colors.white,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 0, 174, 61));
                                      }
                                      setState(() {
                                        passwordState = !passwordState;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  crossFadeState: passwordState
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 100)),*/
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              onTap: null,
                              leading: const Icon(
                                FontAwesomeIcons.phone,
                                color: Colors.white,
                              ),
                              title: const Text(
                                "Phone",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: AnimatedCrossFade(
                                  firstChild: Text(
                                    snapshot.data!.get("phone_number"),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  secondChild: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Type...",
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                    controller: phoneStateController,
                                    autofocus: true,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  crossFadeState: phoneState
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 100)),
                              trailing: AnimatedCrossFade(
                                  firstChild: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        phoneState = !phoneState;
                                      });
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.pencil,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  secondChild: IconButton(
                                    onPressed: () async {
                                      if (!phoneStateController.text
                                          .contains(RegExp(r"^\s*$"))) {
                                        await FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          "phone_number":
                                              phoneStateController.text.trim()
                                        });
                                        phoneStateController.clear();
                                      }
                                      setState(() {
                                        phoneState = !phoneState;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  crossFadeState: phoneState
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 100)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ListTile(
                              onTap: null,
                              leading: const Icon(
                                FontAwesomeIcons.flag,
                                color: Colors.white,
                              ),
                              title: const Text(
                                "Country",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: AnimatedCrossFade(
                                  firstChild: Text(
                                    snapshot.data!.get("origin"),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  secondChild: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Type...",
                                        hintStyle:
                                            TextStyle(color: Colors.white)),
                                    controller: countryStateController,
                                    autofocus: true,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  crossFadeState: countryState
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 100)),
                              trailing: AnimatedCrossFade(
                                  firstChild: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        countryState = !countryState;
                                      });
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.pencil,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  secondChild: IconButton(
                                    onPressed: () async {
                                      if (!countryStateController.text
                                          .contains(RegExp(r"^\s*$"))) {
                                        await FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          "origin":
                                              countryStateController.text.trim()
                                        });
                                        countryStateController.clear();
                                      }
                                      setState(() {
                                        countryState = !countryState;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  crossFadeState: countryState
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 100)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      );
                    }
                  }),
            ),
          ],
        ));
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.4960000);
    path0.quadraticBezierTo(size.width * 0.1971875, size.height * 0.1625000,
        size.width * 0.3925000, size.height * 0.3380000);
    path0.cubicTo(
        size.width * 0.4725000,
        size.height * 0.4130000,
        size.width * 0.5587500,
        size.height * 0.5770000,
        size.width * 0.7400000,
        size.height * 0.4600000);
    path0.quadraticBezierTo(size.width * 0.9359375, size.height * 0.3030000,
        size.width, size.height * 0.2480000);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
