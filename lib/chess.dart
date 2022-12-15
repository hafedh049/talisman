import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class ChessGame extends StatefulWidget {
  const ChessGame({Key? key}) : super(key: key);

  @override
  State<ChessGame> createState() => _ChessGameState();
}

class _ChessGameState extends State<ChessGame> {
  ChessBoardController chessBoardController = ChessBoardController();

  @override
  void dispose() async {
    chessBoardController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    chessBoardController.addListener(() {});
    super.initState();
  }

  BoardColor boardColor = BoardColor.orange;
  bool firstmove = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SpecialMethods.displayAppBar(context: context),
      backgroundColor: primaryColor,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Center(
            child: ChessBoard(
              controller: chessBoardController,
              boardColor: boardColor,
              boardOrientation: PlayerColor.white,
              arrows: firstmove
                  ? [
                      BoardArrow(
                        from: chessBoardController
                            .value.history.last.move.fromAlgebraic,
                        to: chessBoardController
                            .value.history.last.move.toAlgebraic,
                        color: Colors.blueAccent,
                      ),
                    ]
                  : [],
              onMove: () {
                AssetsAudioPlayer.newPlayer().open(
                  Audio("assets/move.mp3"),
                  showNotification: false,
                  volume: 100,
                );
                if (chessBoardController.isCheckMate()) {
                  Fluttertoast.showToast(
                    msg: "Checkmate",
                    textColor: Colors.white,
                    backgroundColor: Colors.purple,
                  );
                } else if (chessBoardController.isDraw()) {
                  Fluttertoast.showToast(
                    msg: "Draw",
                    textColor: Colors.white,
                    backgroundColor: Colors.purple,
                  );
                } else if (chessBoardController.isInCheck()) {
                  Fluttertoast.showToast(
                    msg: "Check",
                    textColor: Colors.white,
                    backgroundColor: Colors.purple,
                  );
                } else if (chessBoardController.isStaleMate()) {
                  Fluttertoast.showToast(
                    msg: "Stalemate",
                    textColor: Colors.white,
                    backgroundColor: Colors.purple,
                  );
                } else if (chessBoardController.isThreefoldRepetition()) {
                  Fluttertoast.showToast(
                    msg: "Threefold Repetition",
                    textColor: Colors.white,
                    backgroundColor: Colors.purple,
                  );
                } else if (chessBoardController.isInsufficientMaterial()) {
                  Fluttertoast.showToast(
                    msg: "Insufficient Material",
                    textColor: Colors.white,
                    backgroundColor: Colors.purple,
                  );
                }
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    chessBoardController.resetBoard();
                    firstmove = false;
                  });
                },
                icon: const Icon(
                  Icons.replay,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    chessBoardController.undoMove();
                  });
                },
                icon: const Icon(
                  Icons.undo,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (chessBoardController.game.half_moves != 0 ||
                        chessBoardController.game.move_number != 1) {
                      firstmove = !firstmove;
                    }
                  });
                },
                icon: Icon(
                  firstmove
                      ? FontAwesomeIcons.arrowsToEye
                      : FontAwesomeIcons.arrowDownZA,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FabCircularMenu(
        ringColor: Colors.white.withOpacity(.5),
        ringDiameter: 300,
        ringWidth: 50,
        fabSize: 40,
        animationDuration: const Duration(milliseconds: 500),
        fabOpenColor: Colors.cyanAccent,
        fabCloseColor: Colors.purple,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                boardColor = BoardColor.orange;
              });
            },
            icon: const Icon(
              Icons.circle,
              color: Colors.orange,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                boardColor = BoardColor.brown;
              });
            },
            icon: const Icon(
              Icons.circle,
              color: Colors.brown,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                boardColor = BoardColor.green;
              });
            },
            icon: const Icon(
              Icons.circle,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                boardColor = BoardColor.darkBrown;
              });
            },
            icon: const Icon(
              Icons.circle,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
