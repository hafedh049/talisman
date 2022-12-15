import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tesla/contactprofile.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/screens.dart';
import 'package:tesla/special_methods.dart';
import 'package:tesla/waiting.dart';

class PeopleList extends StatefulWidget {
  final Map<String, dynamic> userinfo;
  const PeopleList({Key? key, required this.userinfo}) : super(key: key);

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  List<Map<String, dynamic>> peopleList = <Map<String, dynamic>>[];

  late List<Map<String, dynamic>> people = <Map<String, dynamic>>[];

  void searchEngine(String value) {
    setState(() {
      people = peopleList
          .where((contact) =>
              contact["username"]!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AdvancedDrawer(
            backdropColor: const Color.fromARGB(255, 56, 55, 55),
            animationCurve: Curves.linear,
            drawer: DrawerMaker(
              userinfo: widget.userinfo,
            ),
            child: Scaffold(
              backgroundColor: primaryColor,
              appBar: SpecialMethods.displayAppBar(context: context),
              body: Column(
                children: [
                  TextField(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    onChanged: searchEngine,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.searchengin,
                        size: 30,
                        color: Colors.pink,
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          peopleList = snapshot.data!;
                          if (peopleList.isNotEmpty) {
                            return ListView.builder(
                              itemCount: people.length,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 5,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  color: Colors.white.withOpacity(.2),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ContactProfile(
                                            username: people[index]["username"],
                                            followers: people[index]
                                                ["followers"],
                                            following: people[index]
                                                ["following"],
                                            xp: people[index]["xp"],
                                            rank: people[index]["rank"],
                                            email: people[index]["email"],
                                            country: people[index]["origin"],
                                            phoneNumber: people[index]
                                                ["phone_number"],
                                            profilePicturePath: people[index]
                                                ["profile_picture_path"],
                                          ),
                                        ),
                                      );
                                    },
                                    subtitle: Text(
                                      people[index]["about"],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () async {
                                        if (!widget.userinfo["followings_list"]
                                            .contains(people[index]["uid"])) {
                                          var followingslist = widget
                                              .userinfo["followings_list"];
                                          followingslist
                                              .add(people[index]["uid"]);
                                          var followerslist = peopleList[index]
                                              ["followers_list"];
                                          followerslist
                                              .add(widget.userinfo["uid"]);
                                          await FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(widget.userinfo["uid"])
                                              .update(
                                            {"followings_list": followingslist},
                                          ).then(
                                            (value) async {
                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(widget.userinfo["uid"])
                                                  .update(
                                                {
                                                  "following": widget
                                                          .userinfo[
                                                              "followings_list"]
                                                          .length -
                                                      1,
                                                },
                                              );
                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(people[index]["uid"])
                                                  .update(
                                                {
                                                  "followers": people[index]
                                                          ["followers"] +
                                                      1,
                                                  "followers_list":
                                                      followerslist,
                                                },
                                              );
                                            },
                                          );
                                        }
                                      },
                                      icon: !widget.userinfo["followings_list"]
                                              .contains(people[index]["uid"])
                                          ? const Icon(
                                              Icons.people,
                                              color: Colors.green,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.done,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        people[index]["profile_picture_path"],
                                      ),
                                      radius: 30,
                                    ),
                                    title: Text(
                                      people[index]["username"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Flexible(
                              fit: FlexFit.tight,
                              child: Center(
                                child: Text(
                                  "NO FRIENDS",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .snapshots()
                          .map((snapshot) =>
                              snapshot.docs.map((doc) => doc.data()).toList()),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Waiting();
        }
      },
    );
  }
}
