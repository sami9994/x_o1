import 'package:flutter/material.dart';
import 'game_button.dart';
import 'checking.dart';
import 'message.dart';
import 'pcplaying.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'onclick.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Button> buttonList;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    super.initState();
    buttonList = play();
  }

  List<Button> play() {
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

  void playGame(Button pb) {
    setState(() {
      if (activePlayer == 1) {
        pb.maincolor = Colors.orange;
        pb.text = "X";
        activePlayer = 2;
        player1.add(pb.index);
      } else {
        pb.maincolor = Colors.teal;
        pb.text = "O";
        activePlayer = 1;
        player2.add(pb.index);
      }
      pb.enabled = false;
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
          showDialog(
              context: context,
              builder: (_) =>
                  Message("Draw", "press rest to play again", resetTheGame));
        }
      }
    });
  }

  void resetTheGame() {
    try {
      if (Navigator.canPop(context)) Navigator.pop(context);
    } catch (e) {
      print(e);
    }

    setState(() {
      buttonList = play();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'We Play X & O ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(children: <Widget>[
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
              child: RaisedButton(
                padding: EdgeInsets.all(2.0),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Onclick(
                text: 'Reset',
                renk: Colors.red,
                onpressed: () {
                  resetTheGame();
                },
              ),
              Onclick(
                text: 'Single Player',
                renk: Colors.lightBlueAccent,
                onpressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return PcPlaying();
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
