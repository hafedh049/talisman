import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class DigitalClocker extends StatefulWidget {
  const DigitalClocker({Key? key}) : super(key: key);

  @override
  State<DigitalClocker> createState() => _DigitalClockerState();
}

class _DigitalClockerState extends State<DigitalClocker> {
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      AssetsAudioPlayer.newPlayer().open(
        Audio("assets/digitalclocktick.mp3"),
        volume: 100,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: SpecialMethods.displayAppBar(context: context),
      body: Center(
        child: DigitalClock(
          areaDecoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          is24HourTimeFormat: false,
          showSecondsDigit: true,
          areaAligment: AlignmentDirectional.center,
          digitAnimationStyle: Curves.linear,
          hourMinuteDigitTextStyle: const TextStyle(
            color: Colors.green,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
          secondDigitTextStyle: const TextStyle(
            color: Colors.blue,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          amPmDigitTextStyle: const TextStyle(
            color: Colors.pink,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
