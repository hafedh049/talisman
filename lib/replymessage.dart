import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReplyMessage extends StatefulWidget {
  final bool isMe;
  final String name, oldMessage, newMessage, senderImagePath, sendingdate;
  const ReplyMessage({
    Key? key,
    required this.isMe,
    required this.senderImagePath,
    required this.name,
    required this.newMessage,
    required this.oldMessage,
    required this.sendingdate,
  }) : super(key: key);

  @override
  State<ReplyMessage> createState() => _ReplyMessageState();
}

class _ReplyMessageState extends State<ReplyMessage> {
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

  Widget displayReply() {
    return Card(
      color: const Color.fromARGB(127, 20, 68, 101),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Container(
              height: 150,
              width: 5,
              color: const Color.fromARGB(255, 0, 255, 242),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: const Color.fromARGB(65, 122, 121, 121),
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          child: ListTile(
                            title: Text(
                              widget.name,
                              style: const TextStyle(
                                  color: Color.fromARGB(132, 255, 255, 255)),
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: ListTile(
                            title: Text(
                              widget.oldMessage,
                              style: const TextStyle(
                                  color: Color.fromARGB(124, 255, 255, 255)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: ListTile(
                    title: Text(
                      widget.newMessage,
                      style: const TextStyle(color: Colors.white),
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
                displayReply(),
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
                displayReply(),
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
