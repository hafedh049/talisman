import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tesla/chatscreen.dart';
import 'package:tesla/contactprofile.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class ContactList extends StatefulWidget {
  final Map<String, dynamic> userinfo;
  const ContactList({Key? key, required this.userinfo}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Map<String, dynamic>> contactsList = <Map<String, dynamic>>[];

  late List<Map<String, dynamic>> contacts = <Map<String, dynamic>>[
    ...contactsList
  ];

  void searchEngine(String value) {
    setState(() {
      contacts = contactsList
          .where((contact) =>
              contact["username"]!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                    color: Colors.white,
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
                      contactsList = snapshot.data!
                          .where((element) =>
                              widget.userinfo["followings_list"]
                                  .contains(element["uid"]) ||
                              element["followers_list"]
                                  .contains(widget.userinfo["uid"]))
                          .toList();
                      if (contactsList.isNotEmpty) {
                        return ListView.builder(
                          itemCount: contacts.length,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.white.withOpacity(.2),
                              child: ListTile(
                                subtitle: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ChatScreen(
                                          senderProfilePicturePath:
                                              contacts[index]
                                                  ["profile_picture_path"],
                                          currentUserProfilePicturePath: widget
                                              .userinfo["profile_picture_path"],
                                          currentUserUid:
                                              widget.userinfo["uid"],
                                          senderUid: contacts[index]["uid"],
                                          username: contacts[index]["username"],
                                          status: contacts[index]["status"],
                                          color: contacts[index]["status"] ==
                                                  "Offline"
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ),
                                    );
                                  },
                                  child: StreamBuilder<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>(
                                      stream: FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(widget.userinfo["uid"])
                                          .collection("messages")
                                          .doc(contacts[index]["uid"])
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.exists
                                                ? snapshot.data!
                                                    .get("last_message")
                                                : "",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.pink,
                                            ),
                                          );
                                        }
                                      }),
                                ),
                                trailing: CircleAvatar(
                                  backgroundColor:
                                      contacts[index]["status"] == "Offline"
                                          ? Colors.red
                                          : Colors.green,
                                  radius: 4,
                                ),
                                leading: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (c) => ContactProfile(
                                          username: contacts[index]["username"],
                                          followers: contacts[index]
                                              ["followers"],
                                          following: contacts[index]
                                              ["following"],
                                          xp: contacts[index]["xp"],
                                          rank: contacts[index]["rank"],
                                          email: contacts[index]["email"],
                                          country: contacts[index]["origin"],
                                          phoneNumber: contacts[index]
                                              ["phone_number"],
                                          profilePicturePath: contacts[index]
                                              ["profile_picture_path"],
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      contacts[index]["profile_picture_path"],
                                    ),
                                    radius: 30,
                                  ),
                                ),
                                title: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (c) => ChatScreen(
                                          senderProfilePicturePath:
                                              contacts[index]
                                                  ["profile_picture_path"],
                                          currentUserProfilePicturePath: widget
                                              .userinfo["profile_picture_path"],
                                          currentUserUid:
                                              widget.userinfo["uid"],
                                          senderUid: contacts[index]["uid"],
                                          username: contacts[index]["username"],
                                          status: contacts[index]["status"],
                                          color: contacts[index]["status"] ==
                                                  "Offline"
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    contacts[index]["username"],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                              "NO CONTACT",
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
      ),
    );
  }
}
