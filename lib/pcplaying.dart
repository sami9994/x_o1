import 'dart:math';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:x_o/home_page.dart';
import 'game_button.dart';
import 'checking.dart';
import 'message.dart';
import 'onclick.dart';

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
      new Button(index: 1),
      new Button(index: 2),
      new Button(index: 3),
      new Button(index: 4),
      new Button(index: 5),
      new Button(index: 6),
      new Button(index: 7),
      new Button(index: 8),
      new Button(index: 9),
    ];
    return gameButtons;
  }

  void playGame(Button gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.maincolor = Colors.orange;
        gb.text = "X";
        activePlayer = 2;
        player1.add(gb.index);
      } else {
        gb.maincolor = Colors.teal;
        gb.text = "O";
        activePlayer = 1;
        player2.add(gb.index);
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
          if (activePlayer == 2) {
            sleep(Duration(seconds: 1));
            playingByself();
          } else {}
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

  void playingByself() async {
    await new Future.delayed(const Duration(seconds: 1));
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
    int i = buttonList.indexWhere((p) => p.index == cellId);
    playGame(buttonList[i]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Single Player',
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
                itemBuilder: (context, i) => new CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,
                  child: RaisedButton(
                    padding: EdgeInsets.all(9.0),
                    onPressed: buttonList[i].enabled
                        ? () => playGame(buttonList[i])
                        : null,
                    child: Text(
                      buttonList[i].text,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: buttonList[i].maincolor,
                    disabledColor: buttonList[i].maincolor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  Onclick(
                      text: 'Reset',
                      renk: Colors.red,
                      onpressed: () {
                        resetTheGame();
                      }),
                  Onclick(
                    text: 'MultiPlayer',
                    renk: Colors.lightBlueAccent,
                    onpressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ));
                    },
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}

//child: RaisedButton(
//padding: EdgeInsets.all(9.0),
//onPressed: buttonList[i].enabled
//? () => playGame(buttonList[i])
//: null,
//child: Text(
//buttonList[i].text,
//style: TextStyle(color: Colors.white),
//),
//color: buttonList[i].maincolor,
//disabledColor: buttonList[i].maincolor,
//),
