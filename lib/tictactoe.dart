import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/special_methods.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  String lastValue = "X";
  Game game = Game();
  bool gameOver = false;
  int turn = 0;
  List<int> scoreBoard = <int>[0, 0, 0, 0, 0, 0, 0, 0, 0];
  @override
  void initState() {
    game.board = Game.initGameBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: SpecialMethods.displayAppBar(context: context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "IT'S $lastValue TURN",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 56,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/ 3,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(
                Game.boardLength,
                (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            if (game.board![index] == Player.empty) {
                              AssetsAudioPlayer.newPlayer().open(
                                Audio("assets/tic.mp3"),
                                volume: 100,
                              );
                              setState(
                                () {
                                  game.board![index] = lastValue;
                                  turn++;
                                  gameOver = game.winnerCheck(
                                    lastValue,
                                    index,
                                    scoreBoard,
                                    3,
                                  );
                                  if (gameOver) {
                                    showDialoger(
                                        content: "$lastValue IS THE WINNER");
                                  } else if (turn == 9) {
                                    showDialoger(content: "IT'S A DRAW");
                                  }
                                  lastValue = lastValue == "X" ? "O" : "X";
                                },
                              );
                            }
                          },
                    child: Container(
                      width: Game.blockSize,
                      height: Game.blockSize,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue.shade600
                                : Colors.red.shade600,
                            fontSize: 75,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          IconButton(
            onPressed: () {
              setState(
                () {
                  game.board = Game.initGameBoard();
                  lastValue = "X";
                  turn = 0;
                  scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                  gameOver = false;
                },
              );
            },
            icon: const Icon(
              Icons.replay,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  void showDialoger({required String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 27, 30, 66),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  content,
                  style: TextStyle(
                    color: Colors.greenAccent.shade400,
                    fontSize: 30,
                  ),
                ),
              ),
              Center(
                child: IconButton(
                  onPressed: () {
                    setState(
                      () {
                        game.board = Game.initGameBoard();
                        lastValue = "X";
                        turn = 0;
                        scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                        gameOver = false;
                      },
                    );
                    Navigator.of(context).pop(true);
                  },
                  icon: const Icon(
                    Icons.replay,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static const boardLength = 9;
  static const blockSize = 100.0;
  List<String>? board;
  static List<String>? initGameBoard() =>
      List.generate(boardLength, (index) => Player.empty);
  bool winnerCheck(
      String player, int index, List<int> scoreBoard, int gridSize) {
    int row = index ~/ 3;
    int column = index % 3;
    int score = player == "X" ? 1 : -1;
    scoreBoard[row] += score;
    scoreBoard[gridSize + column] += score;
    if (row == column) scoreBoard[2 * gridSize] += score;
    if (gridSize - 1 - column == row) scoreBoard[2 * gridSize + 1] += score;
    if (scoreBoard.contains(3) || scoreBoard.contains(-3)) return true;
    return false;
  }
}
