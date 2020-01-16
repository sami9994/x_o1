import 'package:flutter/material.dart';
import 'game_button.dart';
import 'checking.dart';
import 'message.dart';
import 'pcplaying.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    buttonList = doInit();
  }

  List<Button> doInit() {
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
      buttonList = doInit();
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
                    'play with pc',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return PcPlaying();
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
