import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tesla/contactprofile.dart';
import 'package:tesla/periodictable/cte.dart';

class RankingFriends extends StatefulWidget {
  const RankingFriends({Key? key}) : super(key: key);

  @override
  State<RankingFriends> createState() => _RankingFriendsState();
}

class _RankingFriendsState extends State<RankingFriends> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? rankers;
  Future<void> ranker() async {
    rankers = await FirebaseFirestore.instance
        .collection("users")
        .orderBy("xp", descending: true)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> value) =>
            rankers = value.docs);
    for (int i = 0; i < rankers!.length; i++) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(rankers![i].get("uid"))
          .update(
        {
          "rank": i + 1,
        },
      );
    }
  }

  @override
  void initState() {
    ranker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: StreamBuilder<List<Map<String, dynamic>>>(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final friendsList = snapshot.data;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: friendsList!.length,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => ContactProfile(
                                  username: friendsList[index]["username"],
                                  followers: friendsList[index]["followers"],
                                  following: friendsList[index]["following"],
                                  xp: friendsList[index]["xp"],
                                  rank: friendsList[index]["rank"],
                                  email: friendsList[index]["email"],
                                  country: friendsList[index]["origin"],
                                  phoneNumber: friendsList[index]
                                      ["phone_number"],
                                  profilePicturePath: friendsList[index]
                                      ["profile_picture_path"],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.white.withOpacity(.2),
                            child: ListTile(
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Rank : ${friendsList[index]["rank"]}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "XP : ${friendsList[index]["xp"]}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: friendsList[index]["rank"] <= 3
                                  ? const Icon(
                                      FontAwesomeIcons.crown,
                                      color: Color.fromARGB(255, 254, 244, 146),
                                      size: 20,
                                    )
                                  : null,
                              leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  friendsList[index]["profile_picture_path"],
                                ),
                                radius: 30,
                              ),
                              title: Text(
                                friendsList[index]["username"],
                                style: const TextStyle(
                                  fontSize: 16,
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
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    );
                  }
                },
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .orderBy("xp", descending: true)
                    .snapshots()
                    .map((snapshot) =>
                        snapshot.docs.map((doc) => doc.data()).toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
