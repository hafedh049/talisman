import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageShower extends StatefulWidget {
  const ImageShower({
    Key? key,
    required this.imagePath,
    required this.isMe,
    required this.sendingdate,
    required this.senderImagePath,
  }) : super(key: key);
  final String imagePath, senderImagePath, sendingdate;
  final bool isMe;

  @override
  State<ImageShower> createState() => _ImageShowerState();
}

class _ImageShowerState extends State<ImageShower> {
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

  Widget displayImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        fadeInDuration: const Duration(milliseconds: 300),
        progressIndicatorBuilder: (context, url, progress) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        },
        height: 400,
        width: 200,
        imageUrl: imageUrl,
        fit: BoxFit.fill,
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
                displayImage(widget.imagePath),
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
                displayImage(widget.imagePath),
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
