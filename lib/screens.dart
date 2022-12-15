import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tesla/about.dart';
import 'package:tesla/authentification/signin.dart';
import 'package:tesla/contactslist.dart';
import 'package:tesla/dashboard.dart';
import 'package:tesla/mainpage.dart';
import 'package:tesla/others.dart';
import 'package:tesla/peoplelist.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/profile.dart';
import 'package:tesla/ranking.dart';
import 'package:tesla/special_methods.dart';
import 'package:tesla/waiting.dart';
import 'package:tesla/error.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    InternetConnectionChecker().onStatusChange.listen(
      (event) async {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "status":
              event == InternetConnectionStatus.connected ? "Online" : "Offline"
        });
        Fluttertoast.showToast(
          msg: event == InternetConnectionStatus.connected
              ? "Connected"
              : "No Connection",
          textColor: Colors.white,
          backgroundColor: event == InternetConnectionStatus.connected
              ? Colors.green
              : Colors.red,
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    } else {}
    super.didChangeAppLifecycleState(state);
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;
  Map<String, dynamic> userinfo = <String, dynamic>{};

  Stream<List<Map<String, dynamic>>> readUsers() {
    return FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  late final screens = <Widget>[
    const Neutrino(),
    const RankingFriends(),
    const Profile(),
    ContactList(userinfo: userinfo),
    const Others(),
  ];
  final items = const <Icon>[
    Icon(Icons.home),
    Icon(FontAwesomeIcons.trophy),
    Icon(FontAwesomeIcons.userGraduate),
    Icon(Icons.messenger),
    Icon(FontAwesomeIcons.gamepad),
  ];
  int index = 2;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: readUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Waiting();
        } else if (snapshot.hasError) {
          return Error(error: snapshot.error.toString());
        } else {
          userinfo =
              snapshot.data!.firstWhere((element) => element["uid"] == uid);
          return AdvancedDrawer(
            backdropColor: const Color.fromARGB(255, 56, 55, 55),
            animationCurve: Curves.linear,
            drawer: DrawerMaker(userinfo: userinfo),
            child: Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: primaryColor,
                buttonBackgroundColor: Colors.pink,
                items: items,
                index: index,
                animationCurve: Curves.easeInCirc,
                animationDuration: const Duration(milliseconds: 200),
                onTap: (int index) {
                  setState(
                    () {
                      this.index = index;
                    },
                  );
                },
                height: 45,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              //drawer: DrawerDecorator(userinfo: userinfo),
              extendBody: false /*true*/,
              body: screens[index],
            ),
          );
        }
      },
    );
  }
}

class DrawerMaker extends StatelessWidget {
  const DrawerMaker({Key? key, required this.userinfo}) : super(key: key);
  final Map<String, dynamic> userinfo;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    color: Colors.lightBlueAccent.shade700.withOpacity(.2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              width: 70,
                              height: 70,
                              imageUrl:
                                  snapshot.data!.get("profile_picture_path"),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  snapshot.data!.get("username"),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  snapshot.data!.get("email"),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SpecialMethods.displayListTile(
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Neutrino()));
                    },
                    icon: Icons.home,
                    text: "Home",
                  ),
                  SpecialMethods.displayListTile(
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Dashboard()));
                    },
                    icon: Icons.graphic_eq,
                    text: "Statistics",
                  ),
                  SpecialMethods.displayListTile(
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => PeopleList(
                                    userinfo: userinfo,
                                  )));
                    },
                    icon: Icons.public,
                    text: "Invite Friends",
                  ),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.orangeAccent,
                  ),
                  SpecialMethods.displayListTile(
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AboutMe()));
                    },
                    icon: Icons.info,
                    text: "About",
                  ),
                  SpecialMethods.displayListTile(
                    func: () async {
                      Fluttertoast.showToast(
                        msg: "Signing out",
                        textColor: Colors.white,
                        backgroundColor: Colors.blue,
                        toastLength: Toast.LENGTH_LONG,
                      );
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({"token": "", "status": "Offline"});
                      await FirebaseAuth.instance.signOut();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SignIn()));
                    },
                    icon: Icons.logout,
                    text: "Sign-out",
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightGreenAccent,
              ),
            );
          }
        });
  }
}
