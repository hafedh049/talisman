import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tesla/periodictable/cte.dart';

class Error extends StatefulWidget {
  final String error;
  const Error({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  State<Error> createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: LottieBuilder.asset(
                "assets/${[
                  "error404",
                  "errordialog",
                  "boterror404"
                ][Random().nextInt(3)]}.json",
                animate: true,
                repeat: true,
              ),
            ),
            Flexible(
                fit: FlexFit.tight,
                child: Center(
                  child: Text(
                    widget.error,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
