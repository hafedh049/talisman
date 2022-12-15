import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tesla/analogclock.dart';
import 'package:tesla/chess.dart';
import 'package:tesla/dashboard.dart';
import 'package:tesla/digitalclock.dart';
//import 'package:tesla/machinelearning.dart';
import 'package:tesla/mathformulae.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/periodictable/periodictable.dart';
import 'package:tesla/piano.dart';
import 'package:tesla/special_methods.dart';
import 'package:tesla/texteditor.dart';
import 'package:tesla/tictactoe.dart';

class Others extends StatefulWidget {
  const Others({Key? key}) : super(key: key);

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            SpecialMethods.displayExpandedTile(
              icon: Icon(
                  isExpanded1
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_left,
                  color: Colors.amber),
              onExpansionChanged: (bool isExpanded) {
                if (isExpanded) {
                  setState(() {
                    isExpanded1 = true;
                  });
                } else {
                  setState(() {
                    isExpanded1 = false;
                  });
                }
              },
              title: Row(
                children: const [
                  Icon(
                    Icons.gamepad,
                    color: Colors.amber,
                  ),
                  Text(
                    "Games",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const ChessGame()));
                  },
                  title: const Text(
                    "Chess",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const TicTacToe()));
                  },
                  title: const Text(
                    "Tic Tac Toe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //rotate screen problem
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const Piano()));
                  },
                  title: const Text(
                    "Piano",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SpecialMethods.displayExpandedTile(
              icon: Icon(
                  isExpanded2
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_left,
                  color: Colors.amber),
              onExpansionChanged: (bool isExpanded) {
                if (isExpanded) {
                  setState(() {
                    isExpanded2 = true;
                  });
                } else {
                  setState(() {
                    isExpanded2 = false;
                  });
                }
              },
              title: Row(
                children: const [
                  Icon(
                    Icons.dashboard,
                    color: Colors.amber,
                  ),
                  Text(
                    "Statistics",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Dashboard()));
                  },
                  title: const Text(
                    "Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SpecialMethods.displayExpandedTile(
              icon: Icon(
                  isExpanded3
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_left,
                  color: Colors.amber),
              onExpansionChanged: (bool isExpanded) {
                if (isExpanded) {
                  setState(() {
                    isExpanded3 = true;
                  });
                } else {
                  setState(() {
                    isExpanded3 = false;
                  });
                }
              },
              title: Row(
                children: const [
                  Icon(
                    Icons.stadium,
                    color: Colors.amber,
                  ),
                  Text(
                    "Extra",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                const ListTile(
                  onTap: null,
                  title: Text(
                    "Google Maps (Coming Soon)",
                    style: TextStyle(
                      color: Color.fromARGB(255, 150, 150, 150),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const AnalogClocker()));
                  },
                  title: const Text(
                    "Analog Clock",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const DigitalClocker()));
                  },
                  title: const Text(
                    "Digital Clock",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const MathFormulae()));
                  },
                  title: const Text(
                    "Math Formulae",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const ListTile(
                  onTap: /*() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const MachineLearning()));
                  },*/
                      null,
                  title: Text(
                    "Machine Learning",
                    style: TextStyle(
                      color: Color.fromARGB(255, 170, 170, 170),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const PeriodicTable()));
                  },
                  title: const Text(
                    "Periodic Table",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const TextEditor()));
                  },
                  title: const Text(
                    "Text Editor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
