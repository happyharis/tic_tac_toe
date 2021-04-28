import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final board = List.generate(9, (index) => '');
  int turn = 0;
  bool isPlayer1Turn = true;
  bool gameOver = false;
  final boardAnswers = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  @override
  Widget build(BuildContext context) {
    final checkWinner = () {
      for (var answerIndexes in boardAnswers) {
        final first = board[answerIndexes.first];
        final middle = board[answerIndexes[1]];
        final last = board[answerIndexes.last];
        if (first == middle &&
            middle == last &&
            first == last &&
            first.isNotEmpty) {
          setState(() => gameOver = true);
        }
      }
    };

    final setBox = (int index) {
      if (isPlayer1Turn) {
        board.setAll(index, ['X']);
      } else {
        board.setAll(index, ['0']);
      }
    };

    final pressed = (int index) {
      if (board[index].isNotEmpty) return;
      setState(() {
        setBox(index);
        turn++;
        isPlayer1Turn = !isPlayer1Turn;
        if (turn >= 4) checkWinner();
      });
    };

    return Scaffold(
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          children: List.generate(
            9,
            (index) {
              return FlatButton(
                onPressed: () => pressed(index),
                child: Center(
                  child: Text(
                    gameOver ? winnerText(turn % 2)[index] : board[index],
                    style: TextStyle(fontSize: 120, height: 1.1),
                  ),
                ),
                color: Colors.accents[index],
              );
            },
          ),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}

final winnerText = (int winner) => 'WINNER!$winner!';
