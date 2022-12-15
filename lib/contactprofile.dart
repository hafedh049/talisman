import 'dart:math';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactProfile extends StatefulWidget {
  final String username;
  final int followers;
  final int following;
  final int xp;
  final int rank;
  final String email;
  final String country;
  final String phoneNumber;
  final String profilePicturePath;

  const ContactProfile({
    Key? key,
    required this.username,
    required this.followers,
    required this.following,
    required this.xp,
    required this.rank,
    required this.email,
    required this.country,
    required this.phoneNumber,
    required this.profilePicturePath,
  }) : super(key: key);

  @override
  State<ContactProfile> createState() => _ContactProfileState();
}

class _ContactProfileState extends State<ContactProfile> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecialMethods.displayAppBar(context: context),
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 16, sigmaY: 4, tileMode: TileMode.mirror),
          child: Stack(
            children: [
              Card(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Card(
                          color: Colors.white.withOpacity(.2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedTextKit(
                              pause: const Duration(milliseconds: 50),
                              repeatForever: true,
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  "PROFILE",
                                  speed: const Duration(milliseconds: 1500),
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  colors: [Colors.white, Colors.green],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            child: CircleAvatar(
                              radius: 57,
                              backgroundImage: CachedNetworkImageProvider(
                                  widget.profilePicturePath),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Column(
                              children: [
                                Text(
                                  widget.username,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Badge(
                                        badgeColor: Colors.green,
                                        badgeContent: Text(
                                          widget.followers.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/followers.png",
                                          width: 20,
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Badge(
                                        badgeColor: Colors.green,
                                        badgeContent: Text(
                                          widget.following.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/following.png",
                                          width: 20,
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Badge(
                            badgeColor: Colors.green,
                            badgeContent: Text(
                              widget.xp.toString(),
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
                            badgeColor: Colors.green,
                            badgeContent: Text(
                              widget.rank.toString(),
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
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.envelope,
                          color: Colors.white,
                          size: 20,
                        ),
                        title: Text(
                          widget.email,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.orcid,
                          color: Colors.white,
                          size: 20,
                        ),
                        title: Text(
                          "${widget.country}, ${widget.phoneNumber}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CircularMenu(
                toggleButtonSize: 20,
                toggleButtonColor: const Color.fromARGB(64, 0, 79, 143),
                toggleButtonIconColor: Colors.yellow,
                items: <CircularMenuItem>[
                  CircularMenuItem(
                    onTap: () async {
                      await launchUrlString(
                          "whatsapp://send?phone=${widget.phoneNumber}&text=Hi");
                    },
                    icon: FontAwesomeIcons.whatsapp,
                    color: const Color.fromARGB(64, 0, 79, 143),
                    iconColor: Colors.green,
                    iconSize: 20,
                  ),
                  CircularMenuItem(
                    onTap: () async {
                      await launchUrlString(
                          "mailto:${widget.email}?subject=Important&body=Hello");
                    },
                    icon: FontAwesomeIcons.at,
                    color: const Color.fromARGB(64, 0, 79, 143),
                    iconColor: Colors.orange,
                    iconSize: 20,
                  ),
                  CircularMenuItem(
                    onTap: () async {
                      await launchUrlString("tel:${widget.phoneNumber}");
                    },
                    icon: FontAwesomeIcons.phone,
                    color: const Color.fromARGB(64, 0, 79, 143),
                    iconColor: Colors.blue,
                    iconSize: 20,
                  ),
                  CircularMenuItem(
                    onTap: () async {
                      await launchUrlString("sms:${widget.phoneNumber}");
                    },
                    icon: FontAwesomeIcons.commentSms,
                    color: const Color.fromARGB(64, 0, 79, 143),
                    iconColor: Colors.red,
                    iconSize: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
