import 'dart:async';
import 'package:analog_clock/analog_clock.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class AnalogClocker extends StatefulWidget {
  const AnalogClocker({Key? key}) : super(key: key);

  @override
  State<AnalogClocker> createState() => _AnalogClockerState();
}

class _AnalogClockerState extends State<AnalogClocker> {
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      AssetsAudioPlayer.newPlayer().open(
        Audio("assets/analogclocktick.mp3"),
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
      body: AnalogClock(
        datetime: DateTime.now(),
        showAllNumbers: true,
        showDigitalClock: true,
        showSecondHand: true,
        showNumbers: true,
        showTicks: true,
        useMilitaryTime: true,
        hourHandColor: Colors.blue,
        minuteHandColor: Colors.green,
        secondHandColor: Colors.pink,
        tickColor: const Color.fromARGB(255, 225, 0, 255),
        numberColor: Colors.white,
        isLive: true,
      ),
    );
  }
}
