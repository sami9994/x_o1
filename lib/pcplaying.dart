import 'dart:math';

import 'package:flutter/material.dart';
import 'package:x_o/home_page.dart';
import 'game_button.dart';
import 'checking.dart';
import 'message.dart';

class PcPlaying extends StatefulWidget {
  @override
  _PcPlayingState createState() => _PcPlayingState();
}

class _PcPlayingState extends State<PcPlaying> {
  List<Button> buttonList;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    super.initState();
    buttonList = doInit1();
  }

  List<Button> doInit1() {
    player1 = new List();
    player2 = new List();
    activePlayer = 1;

    var gameButtons = <Button>[
      new Button(id: 1),
      new Button(id: 2),
      new Button(id: 3),
      new Button(id: 4),
      new Button(id: 5),
      new Button(id: 6),
      new Button(id: 7),
      new Button(id: 8),
      new Button(id: 9),
    ];
    return gameButtons;
  }

  void playGame(Button gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.bg = Colors.orange;
        gb.text = "X";
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.bg = Colors.teal;
        gb.text = "O";
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      var winner1 = checkingWinner(player1, player2);
      if (winner1 == 1) {
        showDialog(
            context: context,
            builder: (_) => Message(
                "Player1 has won", "press rest to play again", resetTheGame));
      }
      if (winner1 == 2) {
        showDialog(
            context: context,
            builder: (_) => Message(
                "Player2 has won", "press rest to play again", resetTheGame));
      }

      if (winner1 == -1) {
        if (buttonList.every((E) {
          return E.text != ""; //checking if all of list's item is not empty
        })) {
          {
            showDialog(
                context: context,
                builder: (_) =>
                    Message("Draw", "press rest to play again", resetTheGame));
          }
        } else {
          if (activePlayer == 2)
            playingByself();
          else {}
        }
      }
    });
  }

  void resetTheGame() {
    try {
      buttonList = doInit1();
    } catch (e) {
      print(e);
    }

    setState(() {
      buttonList = doInit1();
    });
  }

  void playingByself() {
    var emptyIndex = List();
    var list = List.generate(10, (j) => j + 1);
    for (var cellId in list) {
      if (!(player1.contains(cellId) || player2.contains(cellId))) {
        emptyIndex.add(cellId);
      }
    }
    var ran = Random();
    var ranIndex = ran.nextInt(emptyIndex.length - 1);
    var cellId = emptyIndex[ranIndex];
    int i = buttonList.indexWhere((p) => p.id == cellId);
    playGame(buttonList[i]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '1 player mode',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: new GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0,
                ),
                padding: EdgeInsets.all(11.0),
                itemCount: 9,
                itemBuilder: (context, i) => new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: RaisedButton(
                    padding: EdgeInsets.all(9.0),
                    onPressed: buttonList[i].enabled
                        ? () => playGame(buttonList[i])
                        : null,
                    child: Text(
                      buttonList[i].text,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: buttonList[i].bg,
                    disabledColor: buttonList[i].bg,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    'Reset',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  color: Colors.red,
                  onPressed: resetTheGame,
                  padding: EdgeInsets.all(20.0),
                ),
                RaisedButton(
                  child: Text(
                    'multyplayer',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ));
                  },
                  padding: EdgeInsets.all(20.0),
                ),
              ],
            ),
          ]),
    );
  }
}
