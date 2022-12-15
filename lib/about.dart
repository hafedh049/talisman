import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  //Text ("2018 ${String.fromCharCode(0x00A9) Author's name")
  @override
  void initState() {
    super.initState();
  }

  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  bool six = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/abouticon.png",
                    ),
                  ),
                  Center(
                    child: SpecialMethods.displayNeutrino(),
                  ),
                  Center(
                    child: AnimatedTextKit(
                      onFinished: () {
                        setState(() {
                          one = true;
                        });
                      },
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          "Version 1.0.0",
                          speed: const Duration(milliseconds: 100),
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  if (one)
                    Center(
                      child: AnimatedTextKit(
                        onFinished: () {
                          setState(() {
                            two = true;
                          });
                        },
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                            "2022 ${String.fromCharCode(0x00A9)} Hafedh Gunichi",
                            speed: const Duration(milliseconds: 100),
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (two)
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Card(
                        color: const Color.fromARGB(95, 96, 125, 139),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedTextKit(
                            totalRepeatCount: 1,
                            onFinished: () {
                              setState(() {
                                three = true;
                              });
                            },
                            pause: const Duration(milliseconds: 100),
                            repeatForever: false,
                            animatedTexts: <AnimatedText>[
                              ColorizeAnimatedText(
                                "About Me",
                                speed: const Duration(milliseconds: 500),
                                textStyle: const TextStyle(fontSize: 35),
                                colors: const [
                                  Colors.white,
                                  Color.fromARGB(255, 0, 255, 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (three)
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: AnimatedTextKit(
                        onFinished: () {
                          setState(() {
                            four = true;
                          });
                        },
                        pause: const Duration(milliseconds: 100),
                        repeatForever: false,
                        totalRepeatCount: 1,
                        animatedTexts: <AnimatedText>[
                          TypewriterAnimatedText(
                            "Hi, my name is HAFEDH GUNICHI",
                            speed: const Duration(milliseconds: 100),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (four)
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: AnimatedTextKit(
                        onFinished: () {
                          setState(() {
                            five = true;
                          });
                        },
                        pause: const Duration(milliseconds: 100),
                        repeatForever: false,
                        totalRepeatCount: 1,
                        animatedTexts: <AnimatedText>[
                          TypewriterAnimatedText(
                            "I'm a computer science student at ISIMM.",
                            speed: const Duration(milliseconds: 100),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (five)
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: AnimatedTextKit(
                        onFinished: () {
                          setState(() {
                            six = true;
                          });
                        },
                        pause: const Duration(milliseconds: 100),
                        repeatForever: false,
                        totalRepeatCount: 1,
                        animatedTexts: <AnimatedText>[
                          TypewriterAnimatedText(
                            "I was trying to put what i learned from flutter on this application, but after a moment i decided to share this app with you for entertainment purposes, fixing errors or bad design and gain more experience.",
                            speed: const Duration(milliseconds: 100),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (six)
              CircularMenu(
                radius: 100,
                toggleButtonSize: 30,
                toggleButtonColor: Colors.yellow,
                items: [
                  CircularMenuItem(
                    icon: FontAwesomeIcons.facebook,
                    color: Colors.blue,
                    iconColor: Colors.white,
                    enableBadge: true,
                    badgeLabel: "*",
                    badgeColor: Colors.white,
                    badgeRadius: 5,
                    badgeTextColor: Colors.purple,
                    onTap: () async {
                      await launchUrlString(
                          "https://www.facebook.com/sagittarius.aurora.25.12.2020/");
                    },
                  ),
                  CircularMenuItem(
                    icon: FontAwesomeIcons.youtube,
                    color: Colors.red,
                    iconColor: Colors.white,
                    enableBadge: true,
                    badgeLabel: "*",
                    badgeColor: Colors.white,
                    badgeRadius: 5,
                    badgeTextColor: Colors.purple,
                    onTap: () async {},
                  ),
                  CircularMenuItem(
                    icon: FontAwesomeIcons.github,
                    color: Colors.black,
                    iconColor: Colors.white,
                    enableBadge: true,
                    badgeLabel: "*",
                    badgeColor: Colors.white,
                    badgeRadius: 5,
                    badgeTextColor: Colors.purple,
                    onTap: () async {
                      await launchUrlString("https://github.com/Shadow-Waves");
                    },
                  ),
                  CircularMenuItem(
                    icon: FontAwesomeIcons.linkedin,
                    color: const Color.fromARGB(255, 0, 77, 139),
                    iconColor: Colors.white,
                    enableBadge: true,
                    badgeLabel: "*",
                    badgeColor: Colors.white,
                    badgeRadius: 5,
                    badgeTextColor: Colors.purple,
                    onTap: () async {
                      await launchUrlString(
                          "https://www.linkedin.com/in/hafedh-gunichi-a18a60222/");
                    },
                  ),
                  CircularMenuItem(
                    icon: FontAwesomeIcons.envelope,
                    color: Colors.orange,
                    iconColor: Colors.white,
                    enableBadge: true,
                    badgeLabel: "*",
                    badgeColor: Colors.white,
                    badgeRadius: 5,
                    badgeTextColor: Colors.purple,
                    onTap: () {},
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
