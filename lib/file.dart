import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FileShower extends StatefulWidget {
  const FileShower({
    Key? key,
    required this.isMe,
    required this.type,
    required this.downloadProgressValue,
    required this.sendingdate,
    required this.senderImagePath,
  }) : super(key: key);
  final bool isMe;
  final String type, senderImagePath, sendingdate;
  final double? downloadProgressValue;
  @override
  State<FileShower> createState() => _FileShowerState();
}

class _FileShowerState extends State<FileShower> {
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

  Widget displayFile() {
    return Card(
      elevation: 8,
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            color: const Color.fromARGB(255, 250, 205, 138),
            width: 50,
            child: widget.downloadProgressValue == null ||
                    widget.downloadProgressValue! < 1
                ? const IconButton(onPressed: null, icon: Icon(Icons.download))
                : const IconButton(
                    onPressed: null, icon: Icon(Icons.download_done)),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.type[0].toUpperCase()}${widget.type.substring(1)} File",
                style: const TextStyle(color: Colors.white),
              ),
              Container(
                width: 150,
                child: LinearProgressIndicator(
                  value: widget.downloadProgressValue != null
                      ? widget.downloadProgressValue
                      : 0,
                  backgroundColor: Colors.white,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
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
                displayFile(),
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
                displayFile(),
                const SizedBox(
                  width: 10,
                ),
                reactButton(),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
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
