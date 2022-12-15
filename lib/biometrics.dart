import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tesla/periodictable/cte.dart';

class Biometrics extends StatefulWidget {
  const Biometrics({Key? key}) : super(key: key);

  @override
  State<Biometrics> createState() => _BiometricsState();
}

class _BiometricsState extends State<Biometrics> {
  TextEditingController emailfieldController = TextEditingController(text: "");
  LocalAuthentication auth = LocalAuthentication();
  bool canCheckBiometric = false;
  List<BiometricType> availableBiometrics = [];
  String authorized = "not autherized";
  bool done = false;
  Future<void> checkBiometric() async {
    bool canYouCheckBiometric;
    try {
      canYouCheckBiometric =
          await auth.canCheckBiometrics || await auth.isDeviceSupported();
      if (!mounted) {
        setState(() {
          canCheckBiometric = canYouCheckBiometric;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> availableBiometric() async {
    List<BiometricType> theAvailableBiometrics;
    try {
      theAvailableBiometrics = await auth.getAvailableBiometrics();
      if (!mounted) {
        setState(() {
          availableBiometrics = theAvailableBiometrics;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> authentificate() async {
    bool authentificated;
    try {
      authentificated = await auth.authenticate(
        localizedReason: "move your finger smoothly",
        options: const AuthenticationOptions(
          biometricOnly: true,
          //stickyAuth: true,
        ),
      );
      if (authentificated) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailfieldController.text.trim());
      }
      setState(() {
        authorized = authentificated ? "Authorized Success" : "Failed To Scan";
      });
      print(authorized);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    checkBiometric();
    availableBiometric();
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        msg: "Tap on the fingerprint.");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: !done
            ? IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor:
                              const Color.fromARGB(32, 33, 149, 243),
                          textColor: Colors.white,
                          msg: "Please enter your email.");
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
                                    controller: emailfieldController,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        FontAwesomeIcons.envelopeCircleCheck,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      labelText: "E-mail",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    color: Colors.green,
                                    onPressed: () async {
                                      if (emailfieldController.text.contains(
                                          RegExp(
                                              r"[a-zA-Z]\w+\@\w+\.\w{2,3}"))) {
                                        authentificate();
                                        Fluttertoast.showToast(
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor: Colors.blue,
                                            textColor: Colors.white,
                                            msg:
                                                "Recovery link successfully sent to your email");

                                        Navigator.pop(context);
                                        await Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () {},
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            msg: "verify your email");
                                      }
                                    },
                                    child: const Text(
                                      "Send Link",
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
                icon: const Icon(
                  FontAwesomeIcons.fingerprint,
                  color: Colors.greenAccent,
                  size: 50,
                ),
              )
            : const Text(
                "check your inbox for the link",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
