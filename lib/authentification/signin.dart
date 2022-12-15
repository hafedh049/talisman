import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:lottie/lottie.dart';
import 'package:tesla/authentification/createaccount.dart';
import 'package:tesla/resetpassword.dart';
import 'package:tesla/screens.dart';
import 'package:tesla/special_methods.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> /*with TickerProviderStateMixin*/ {
  /* late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 2,
    ),
  )..repeat();
  late Animation<double> animation =
      CurvedAnimation(parent: animationController, curve: Curves.linear);*/

  @override
  void reassemble() {
    if (Platform.isAndroid) {}
    super.reassemble();
  }

  @override
  void dispose() {
    //animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? mtoken;
  FirebaseMessaging fcmInstance = FirebaseMessaging.instance;
  void getToken() async {
    await fcmInstance.getToken().then((value) {
      mtoken = value;
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  bool isNotVisible = true;
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 59, 59, 59),
            child: CustomPaint(
              size: Size(
                  MediaQuery.of(context).size.width,
                  (MediaQuery.of(context).size.width * 2.1) //1.875
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RRPSCustomPainter(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                const SizedBox(
                  height: 20,
                ),
                /* LottieBuilder.asset(
                  "assets/main.json",
                  repeat: true,
                  animate: true,
                  width: 250,
                  height: 250,
                ),*/
                /*RotationTransition(
                  turns: animation,
                  child: Center(
                    child: Image.asset(
                      "assets/tesla.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),*/
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpecialMethods.displayTextFormField(
                        autofocus: false,
                        obscureText: false,
                        maxLines: 1,
                        func: (str) {
                          return null;
                        },
                        controller: emailController,
                        focusNode: null,
                        hintText: "E-mail",
                        prefixIcon: const Icon(
                          Icons.email,
                          size: 20,
                          color: Colors.green,
                        ),
                        suffixIcon: null,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SpecialMethods.displayTextFormField(
                        autofocus: false,
                        obscureText: isNotVisible,
                        maxLines: 1,
                        func: (str) {
                          return null;
                        },
                        controller: passwordController,
                        focusNode: null,
                        hintText: "Password",
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 20,
                          color: Colors.green,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isNotVisible = !isNotVisible;
                            });
                          },
                          icon: Icon(
                            isNotVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          MaterialButton(
                            color: Colors.red,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            onPressed: () async {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email:
                                      emailController.text.toLowerCase().trim(),
                                  password: passwordController.text
                                      .toLowerCase()
                                      .trim(),
                                );

                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({"token": mtoken});
                                //Navigator.pop(context); is not working
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Screens(),
                                  ),
                                );
                              } catch (exception) {
                                SpecialMethods.displayDialog(
                                    context: context,
                                    title: "Error Occured",
                                    content: exception.toString());
                              }
                            },
                            child: const Icon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SpecialMethods.displayMaterialButton(
                            color: Colors.blue,
                            whilePresesed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const CreateAccount(),
                                ),
                              );
                            },
                            icon: FontAwesomeIcons.creativeCommonsSamplingPlus,
                            text: "Sign Up",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Resetter(),
                      ),
                    ),
                    icon: const Icon(
                      FontAwesomeIcons.shieldHalved,
                      color: Colors.green,
                      size: 40,
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

class RRPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 255, 211, 94)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.1986667);
    path0.quadraticBezierTo(size.width * 0.1593750, size.height * 0.1000000,
        size.width * 0.3200000, size.height * 0.0906667);
    path0.quadraticBezierTo(size.width * 0.6362500, size.height * 0.0676667,
        size.width * 0.7475000, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
      ..color = Colors.white.withOpacity(.3)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path1 = Path();
    path1.moveTo(0, size.height * 0.1973333);
    path1.quadraticBezierTo(size.width * 0.0156250, size.height * 0.1696667,
        size.width * 0.1250000, size.height * 0.1306667);
    path1.quadraticBezierTo(size.width * 0.1725000, size.height * 0.1070000,
        size.width * 0.3075000, size.height * 0.0906667);
    path1.lineTo(size.width * 0.4275000, size.height * 0.0786667);
    path1.quadraticBezierTo(size.width * 0.5243750, size.height * 0.0673333,
        size.width * 0.5600000, size.height * 0.0600000);
    path1.cubicTo(
        size.width * 0.5887500,
        size.height * 0.0513333,
        size.width * 0.6437500,
        size.height * 0.0380000,
        size.width * 0.6750000,
        size.height * 0.0306667);
    path1.quadraticBezierTo(size.width * 0.6937500, size.height * 0.0216667,
        size.width * 0.7500000, 0);
    path1.lineTo(size.width, 0);
    path1.lineTo(size.width, size.height * 0.0346667);
    path1.quadraticBezierTo(size.width * 0.9043750, size.height * 0.0520000,
        size.width * 0.9025000, size.height * 0.0613333);
    path1.quadraticBezierTo(size.width * 0.8525000, size.height * 0.0810000,
        size.width * 0.8300000, size.height * 0.1333333);
    path1.quadraticBezierTo(size.width * 0.8287500, size.height * 0.1663333,
        size.width * 0.8050000, size.height * 0.1880000);
    path1.cubicTo(
        size.width * 0.7950000,
        size.height * 0.2100000,
        size.width * 0.7243750,
        size.height * 0.2623333,
        size.width * 0.6850000,
        size.height * 0.2826667);
    path1.cubicTo(
        size.width * 0.6500000,
        size.height * 0.3033333,
        size.width * 0.5506250,
        size.height * 0.3433333,
        size.width * 0.5100000,
        size.height * 0.3520000);
    path1.cubicTo(
        size.width * 0.4681250,
        size.height * 0.3623333,
        size.width * 0.4143750,
        size.height * 0.3820000,
        size.width * 0.2900000,
        size.height * 0.3906667);
    path1.cubicTo(
        size.width * 0.2425000,
        size.height * 0.3933333,
        size.width * 0.1862500,
        size.height * 0.3933333,
        size.width * 0.1100000,
        size.height * 0.3746667);
    path1.quadraticBezierTo(size.width * 0.0562500, size.height * 0.3633333, 0,
        size.height * 0.3453333);
    path1.lineTo(0, size.height * 0.1973333);
    path1.close();

    canvas.drawPath(path1, paint1);

    Paint paint3 = Paint()
      ..color = const Color.fromARGB(255, 88, 217, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path3 = Path();
    path3.moveTo(size.width * 0.6600000, size.height * 0.2960000);
    path3.quadraticBezierTo(size.width * 0.6750000, size.height * 0.4336667,
        size.width, size.height * 0.5293333);
    path3.lineTo(size.width, size.height * 0.0333333);
    path3.quadraticBezierTo(size.width * 0.9162500, size.height * 0.0476667,
        size.width * 0.8975000, size.height * 0.0613333);
    path3.cubicTo(
        size.width * 0.8612500,
        size.height * 0.0773333,
        size.width * 0.8362500,
        size.height * 0.1026667,
        size.width * 0.8325000,
        size.height * 0.1260000);
    path3.cubicTo(
        size.width * 0.8175000,
        size.height * 0.1580000,
        size.width * 0.800000,
        size.height * 0.1900000,
        size.width * 0.7700000,
        size.height * 0.2226667);
    path3.cubicTo(
        size.width * 0.7068750,
        size.height * 0.2740000,
        size.width * 0.7425000,
        size.height * 0.2410000,
        size.width * 0.6600000,
        size.height * 0.2960000);
    path3.close();

    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
