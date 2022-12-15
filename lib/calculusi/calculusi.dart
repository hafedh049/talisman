import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:lottie/lottie.dart';
import 'package:tesla/juicyquestions/juicyquestions.dart';
import 'package:text_highlight/text_highlight.dart';
import 'package:text_highlight/tools/highlight_theme.dart';

class JuicyMath extends StatefulWidget {
  final List<Question> questionsList;
  final String what;
  const JuicyMath({Key? key, required this.questionsList, required this.what})
      : super(key: key);

  @override
  State<JuicyMath> createState() => _JuicyMathState();
}

class _JuicyMathState extends State<JuicyMath> {
  int questionNumber = 0;
  int score = 0;
  bool isLocked = false;
  late List<Question> questionsList;
  PageController pageViewScrollController = PageController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? rankers;
  Map<String, dynamic> mapper = {
    "c": HighlightTextModes.C,
    "python": HighlightTextModes.PYTHON,
  };

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
          "rank": (i + 1).toString(),
        },
      );
    }
  }

  fixPage() async {
    await FirebaseFirestore.instance
        .collection("quizzes")
        .doc(FirebaseAuth.instance.currentUser!.uid + widget.what)
        .get()
        .then((value) async {
      await pageViewScrollController.animateToPage(value.get("currentIndex"),
          duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
      questionNumber = value.get("currentIndex");
      score = value.get("currentScore");
    });
    setState(() {});
  }

  @override
  void initState() {
    fixPage();
    questionsList = widget.questionsList;
    super.initState();
  }

  Widget buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: widget.what.contains("regex")
                ? Math.tex(
                    question.text,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                : HighlightText(
                    question.text,
                    padding: 8,
                    mode: mapper[widget.what],
                    fontSize: 18,
                    theme: const HighlightTheme(),
                  ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Expanded(
          child: OptionsWidget(
            question: question,
            onClickedOption: (Option option) async {
              if (!question.isLocked) {
                setState(() {
                  question.isLocked = true;
                  question.selectedChoice = option;
                });
                isLocked = question.isLocked;
                if (question.selectedChoice!.isCorrect) {
                  AssetsAudioPlayer.newPlayer().open(
                    Audio("assets/correct.mp3"),
                    volume: 100,
                  );

                  score += 10;
                  await FirebaseFirestore.instance
                      .collection("quizzes")
                      .doc(FirebaseAuth.instance.currentUser!.uid + widget.what)
                      .set({
                    "currentScore": score,
                  }, SetOptions(merge: true));
                } else {
                  AssetsAudioPlayer.newPlayer().open(
                    Audio("assets/wrong.mp3"),
                    volume: 100,
                  );
                }
              }
            },
          ),
        ),
        isLocked ? buildElevatedButton() : const SizedBox.shrink(),
      ],
    );
  }

  Widget buildElevatedButton() {
    return Align(
      alignment: Alignment.topRight,
      child: ElevatedButton(
          onPressed: () async {
            if (questionNumber + 1 < questionsList.length) {
              pageViewScrollController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceIn);
              questionNumber++;
              isLocked = false;
              await FirebaseFirestore.instance
                  .collection("quizzes")
                  .doc(FirebaseAuth.instance.currentUser!.uid + widget.what)
                  .set({"currentIndex": questionNumber},
                      SetOptions(merge: true));
              setState(() {});
            } else {
              int oldxp = 0;
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get()
                  .then((value) => oldxp = value.get("xp"));
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({"xp": oldxp + score});
              ranker();
              AssetsAudioPlayer.newPlayer().open(
                Audio("assets/congrats.mp3"),
                volume: 100,
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      LottieBuilder.asset(
                        "assets/firecracks.json",
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 25,
                              ),
                              child: Text(
                                "You Got",
                              ),
                            ),
                            DefaultTextStyle(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              child: Text(
                                "$score",
                              ),
                            ),
                            const Divider(
                              indent: 150,
                              endIndent: 150,
                              thickness: 1,
                              color: Colors.amber,
                            ),
                            DefaultTextStyle(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              child: Text(
                                "${questionsList.length * 10}",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            }
          },
          child: questionNumber + 1 < questionsList.length
              ? const Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                )
              : const Text('See the results')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 35, 65),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 32,
          ),
          Expanded(
            child: PageView.builder(
              controller: pageViewScrollController,
              onPageChanged: (int value) {},
              itemCount: questionsList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return buildQuestion(questionsList[index]);
              },
            ),
          ),
          Math.tex(
            r"\frac{"
            "${questionNumber + 1}"
            r"}{"
            "${questionsList.length}"
            r"}",
            textStyle: const TextStyle(
              color: Colors.orange,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;
  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: question.choices
            .map((Option option) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildOption(context, option),
                ))
            .toList(),
      ),
    );
  }

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 126, 126, 126),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            option.text.contains(RegExp(r"(\^|\\\w+{)"))
                ? Math.tex(
                    option.text,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )
                : Text(
                    option.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
            getIconForOption(option, question),
          ],
        ),
      ),
    );
  }

  getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedChoice;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect ? Colors.green : Colors.red;
      } else if (option.isCorrect) {
        return Colors.green;
      }
    }
    return Colors.grey;
  }

  getIconForOption(Option option, Question question) {
    final isSelected = option == question.selectedChoice;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.cancel,
                color: Colors.red,
              );
      } else if (option.isCorrect) {
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
        );
      }
    }
    return const SizedBox.shrink();
  }
}
