import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tesla/calculusi/calculusi.dart';
import 'package:tesla/juicyquestions/juicyquestions.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class SecondPage extends StatefulWidget {
  final String treasure;
  const SecondPage({Key? key, required this.treasure}) : super(key: key);
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  /*void demandePermission() async {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    if (!await Permission.accessMediaLocation.isGranted) {
      await Permission.accessMediaLocation.request();
    }
    if (!await Permission.mediaLibrary.isGranted) {
      await Permission.mediaLibrary.request();
    }
  }*/

  @override
  void initState() {
    /* demandePermission();
    try {
      //print(Directory.current.path);
      print(Directory.current);
      tasksList = File("/").readAsLinesSync();
      print(tasksList);
    } catch (e) {
      print(e);
    }*/

    super.initState();
  }

  showRatingStars(double rate) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: AlertDialog(
            backgroundColor: primaryColor,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBarIndicator(
                  unratedColor: Colors.white,
                  itemPadding: const EdgeInsets.all(8.0),
                  itemSize: 20,
                  rating: rate,
                  itemBuilder: (BuildContext context, int index) {
                    return const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 0, 119),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Map<String, int> progressValues = <String, int>{
    "Integrals": integralQuestions.length,
    "Python": pythonQuestions.length,
    "Matrix": matrixQuestions.length,
    "C": cQuestions.length,
  };
  Widget displayCard({
    required String subtitle,
    required Color color,
    required int progressvalue,
    required void Function() func,
    required void Function() lpfunc,
  }) {
    return Card(
      color: const Color.fromARGB(255, 45, 58, 65),
      child: ListTile(
        subtitle: Column(
          children: [
            Center(
              child: Text(
                subtitle,
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: LinearProgressIndicator(
                  value: (progressvalue + 1) / progressValues[subtitle]!,
                  color: Colors.red.shade200,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        onTap: func,
        onLongPress: () {
          lpfunc();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Map> subjectsList = <String, Map>{
      "Programming": {
        0: [
          "Python",
          Colors.white,
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return JuicyMath(
                    questionsList: pythonQuestions,
                    what: "python",
                  );
                },
              ),
            );
          },
          4.5,
          "python"
        ],
        1: [
          "C",
          Colors.red,
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return JuicyMath(
                    questionsList: cQuestions,
                    what: "c",
                  );
                },
              ),
            );
          },
          3.0,
          "c"
        ],
      },
      "Mathematics": {
        0: [
          "Integrals",
          Colors.green,
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return JuicyMath(
                    questionsList: integralQuestions,
                    what: "regex_integral",
                  );
                },
              ),
            );
          },
          5.0,
          "regex_integral"
        ],
        1: [
          "Matrix",
          Colors.pink,
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return JuicyMath(
                    questionsList: matrixQuestions,
                    what: "regex_matrix",
                  );
                },
              ),
            );
          },
          4.0,
          "regex_matrix"
        ],
      },
      "Physics": {
        0: [
          "Electricity",
          Colors.brown,
          () {},
        ],
      },
      "Chemistry": {
        0: [
          "Atoms",
          Colors.blue,
          () {},
        ],
      },
    };
    return Scaffold(
      appBar: SpecialMethods.displayAppBar(context: context),
      backgroundColor: primaryColor,
      body: ListView.builder(
        itemCount: subjectsList[widget.treasure]!.length,
        itemBuilder: (context, index) {
          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("quizzes")
                  .doc(FirebaseAuth.instance.currentUser!.uid +
                      subjectsList[widget.treasure]![index][4])
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return displayCard(
                    progressvalue: snapshot.data!.get("currentIndex") ?? 0,
                    subtitle: subjectsList[widget.treasure]![index][0],
                    color: subjectsList[widget.treasure]![index][1],
                    func: subjectsList[widget.treasure]![index][2],
                    lpfunc: () {
                      showRatingStars(subjectsList[widget.treasure]![index][3]);
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
