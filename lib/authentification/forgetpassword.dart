import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:tesla/periodictable/cte.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  /*Widget boxer({first, last}) {
    return SizedBox(
      width: 64,
      height: 68,
      child: TextFormField(
        onSaved: (pini) {},
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: "0",
            hintStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        textAlign: TextAlign.center,
      ),
    );
  }*/
  @override
  void dispose() {
    super.dispose();
    pinController.dispose();
  }

  @override
  void initState() {
    generatedPin = String.fromCharCodes(
        List.generate(4, (index) => 48 + Random().nextInt(10)));
    super.initState();
  }

  TextEditingController pinController = TextEditingController(text: "");

  final TextEditingController phonefieldController =
      TextEditingController(text: "");
  String generatedPin = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          Center(
            child: PinCodeTextField(
              maxLength: 4,
              controller: pinController,
              highlight: true,
              highlightAnimation: true,
              highlightAnimationBeginColor:
                  const Color.fromARGB(255, 0, 81, 148),
              highlightAnimationEndColor:
                  const Color.fromARGB(255, 182, 209, 255),
              highlightColor: Colors.blue,
              highlightAnimationDuration: const Duration(seconds: 2),
              defaultBorderColor: Colors.white,
              hasTextBorderColor: Colors.green,
              onTextChanged: (p0) {},
              onDone: (text) {},
              autofocus: true,
              hasUnderline: true,
              pinBoxColor: Colors.transparent,
              pinTextStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 0),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.teal,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        Fluttertoast.showToast(
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor:
                                const Color.fromARGB(57, 33, 149, 243),
                            textColor: Colors.white,
                            msg:
                                "Attention! the phone number should be exactly the same as you were created your account (country code or spaces between digits if you add), otherwise you will not receive the password recovery link in your inbox.");
                        return BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 3,
                            sigmaY: 3,
                          ),
                          child: AlertDialog(
                            backgroundColor: Colors.white.withOpacity(.15),
                            content: Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextFormField(
                                      controller: phonefieldController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(
                                          FontAwesomeIcons.phone,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        labelText: "Phone",
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      color: Colors.green,
                                      onPressed: () async {
                                        if (phonefieldController.text.contains(
                                            RegExp(r"(\+\d{1,3})?[\d ]+"))) {
                                          Fluttertoast.showToast(
                                              toastLength: Toast.LENGTH_LONG,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              msg: generatedPin);

                                          Navigator.pop(context);
                                          await Future.delayed(
                                            const Duration(milliseconds: 1000),
                                            () {
                                              pinController.text = generatedPin;
                                            },
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                              toastLength: Toast.LENGTH_LONG,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              msg:
                                                  "Please enter a valid phone number");
                                        }
                                      },
                                      child: const Text(
                                        "Send SMS",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text(
                    "Phone Number",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.pink,
                  onPressed: () async {
                    if (pinController.text == generatedPin) {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .where("phone_number",
                              isEqualTo: phonefieldController.text)
                          .get()
                          .then(
                        (value) async {
                          if (value.docs.isNotEmpty) {
                            FirebaseAuth.instance.sendPasswordResetEmail(
                                email: value.docs.first.get("email"));
                            Fluttertoast.showToast(
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                msg: "link sent to your mail successfully.");
                          } else {
                            Fluttertoast.showToast(
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                msg: "No account with this phone number!");
                          }
                        },
                      );
                      phonefieldController.clear();
                      print("ok");
                    }
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
