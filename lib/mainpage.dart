import 'package:flutter/material.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/secondpage.dart';

class Neutrino extends StatefulWidget {
  const Neutrino({Key? key}) : super(key: key);

  @override
  State<Neutrino> createState() => _NeutrinoState();
}

class _NeutrinoState extends State<Neutrino> {
  Widget displayCard({
    required String text,
    required String subtitle,
    required Color color,
    required void Function() func,
  }) {
    return Card(
      color: const Color.fromARGB(255, 39, 52, 59),
      child: ListTile(
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.fade,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        onTap: func,
        title: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<int, List> subjectsList = <int, List>{
      0: [
        "Programming",
        "Programming isn't about what you know, it's about what you can figure out.",
        Colors.yellow,
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => const SecondPage(treasure: "Programming")));
        },
      ],
      1: [
        "Mathematics",
        "Mathematics is the queen of science, and arithmetic the queen of mathematics.",
        Colors.pink,
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => const SecondPage(treasure: "Mathematics")));
        },
      ],
      2: [
        "Physics (Coming Soon)",
        //"Energy is liberated matter, matter is energy waiting to happen.",
        "",
        Colors.white.withOpacity(.5),
        () {
          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => const SecondPage(treasure: "Physics")));*/
        },
      ],
      3: [
        "Chemistry (Coming Soon)",
        //"Chemistry is good when you make love with it. Chemistry is bad when you make crack with it.",
        "",
        Colors.white.withOpacity(.5),
        /*() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => const SecondPage(treasure: "Chemistry")));
        },*/
        () {}
      ],
    };
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: subjectsList.length,
          itemBuilder: (context, index) {
            return displayCard(
              text: subjectsList[index]![0],
              subtitle: subjectsList[index]![1],
              color: subjectsList[index]![2],
              func: subjectsList[index]![3],
            );
          },
        ),
      ),
    );
  }
}
