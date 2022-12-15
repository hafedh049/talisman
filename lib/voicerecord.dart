// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VoiceRecord extends StatefulWidget {
  const VoiceRecord({
    Key? key,
    required this.isMe,
    required this.imageUrl,
    required this.senderImagePath,
    required this.sendingdate,
  }) : super(key: key);
  final bool isMe;
  final String imageUrl, senderImagePath, sendingdate;
  @override
  State<VoiceRecord> createState() => _VoiceRecordState();
}

class _VoiceRecordState extends State<VoiceRecord> {
  Widget reactButton() {
    return ReactionButton(
      boxOffset: const Offset(10, 10),
      boxPosition: VerticalPosition.TOP,
      boxHorizontalPosition: HorizontalPosition.CENTER,
      boxColor: Colors.transparent,
      boxElevation: 5,
      boxRadius: 25,
      boxDuration: const Duration(
        milliseconds: 200,
      ),
      shouldChangeReaction: true,
      boxPadding: const EdgeInsets.all(8.0),
      boxReactionSpacing: 10,
      itemScale: .6,
      itemScaleDuration: const Duration(
        milliseconds: 300,
      ),
      initialReaction: Reaction(
        icon: const Icon(
          FontAwesomeIcons.faceSmile,
          size: 20,
          color: Colors.white,
        ),
        value: "MAIN",
      ),
      onReactionChanged: (value) {},
      reactions: <Reaction<String>>[
        Reaction(
          title: const Text(
            "Love",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          icon: const Icon(
            FontAwesomeIcons.heart,
            size: 20,
            color: Colors.pinkAccent,
          ),
          value: "LOVE",
        ),
        Reaction(
          title: const Text(
            "Haha",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          icon: const Icon(
            FontAwesomeIcons.faceGrinTears,
            size: 20,
            color: Colors.yellowAccent,
          ),
          value: "HAHA",
        ),
        Reaction(
          title: const Text(
            "Wow",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          icon: const Icon(
            FontAwesomeIcons.faceFlushed,
            size: 20,
            color: Colors.blueAccent,
          ),
          value: "WOW",
        ),
        Reaction(
          title: const Text(
            "Sad",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          icon: const Icon(
            FontAwesomeIcons.faceSadCry,
            size: 20,
            color: Colors.orangeAccent,
          ),
          value: "SAD",
        ),
        Reaction(
          title: const Text(
            "Angry",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          icon: const Icon(
            FontAwesomeIcons.faceAngry,
            size: 20,
            color: Colors.red,
          ),
          value: "ANGRY",
        ),
      ],
    );
  }

  AssetsAudioPlayer playeh = AssetsAudioPlayer.newPlayer();
  @override
  void dispose() {
    playeh.dispose();
    super.dispose();
  }

  @override
  void initState() {
    playeh.setVolume(1);
    playeh.current.listen((event) {
      playeh.current.hasValue
          ? setState(
              () {},
            )
          : null;
    });
    super.initState();
  }

  Widget displayVoice() {
    bool isPlayeh = playeh.isPlaying.value;
    return Card(
      elevation: 8,
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            color: const Color.fromARGB(255, 250, 205, 138),
            width: 50,
            child: !isPlayeh || !playeh.current.hasValue
                ? IconButton(
                    onPressed: () async {
                      await playeh.open(Audio.network(widget.imageUrl));
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      await playeh.stop();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.stop,
                      color: Colors.white,
                    ),
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            child: AudioWave(
              beatRate: const Duration(milliseconds: 100),
              animation: true,
              bars: playeh.current.hasValue
                  ? [
                      for (int i = 0;
                          i <
                              (playeh.current.value == null
                                  ? 0
                                  : playeh.current.value!.audio.duration
                                          .inSeconds %
                                      150);
                          i++)
                        AudioWaveBar(
                            radius: 5,
                            /*gradient: LinearGradient(
                              colors: [
                                Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                                Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              ],
                            ),*/
                            heightFactor: (Random().nextInt(7) + 1) / 10,
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)]),
                    ]
                  : [],
              height: 70,
              width: 150,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isMe) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                reactButton(),
                const SizedBox(
                  width: 10,
                ),
                displayVoice(),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                widget.sendingdate,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.amber,
                  child: CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(widget.senderImagePath),
                    radius: 17,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                displayVoice(),
                const SizedBox(
                  width: 10,
                ),
                reactButton(),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                widget.sendingdate,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        ),
      );
    }
  }
}
