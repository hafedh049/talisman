import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:piano/piano.dart';

class Piano extends StatefulWidget {
  const Piano({Key? key}) : super(key: key);

  @override
  State<Piano> createState() => _PianoState();
}

class _PianoState extends State<Piano> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractivePiano(
          animateHighlightedNotes: true,
          useAlternativeAccidentals: true,
          //hideScrollbar: true,
          highlightedNotes: [
            NotePosition(note: Note.C, octave: 4),
            NotePosition(note: Note.C, octave: 5),
            NotePosition(note: Note.C, octave: 6),
            NotePosition(note: Note.C, octave: 2),
            NotePosition(note: Note.C, octave: 3),
          ],
          naturalColor: Colors.white,
          accidentalColor: Colors.black,
          keyWidth: 60,
          noteRange: NoteRange.forClefs(Clef.values),
          onNotePositionTapped: (position) {
            AssetsAudioPlayer.newPlayer().open(
                Audio(
                  "assets/${position.name.length == 3 ? position.name.replaceFirst(position.name[1], 'b') : position.name}.mp3",
                ),
                volume: 1 /*between 0 and 1*/);
          },
        ),
      ),
    );
  }
}
