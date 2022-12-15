import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tesla/periodictable/cte.dart';

class Waiting extends StatefulWidget {
  const Waiting({Key? key}) : super(key: key);

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  /* @override
  void initState() {
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: LottieBuilder.asset(
          "assets/studying.json",
          animate: true,
          repeat: true,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
