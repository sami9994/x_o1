import 'package:flutter/material.dart';

class Onclick extends StatelessWidget {
  Onclick({this.text, this.renk, this.onpressed});

  final String text;
  final Color renk;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 15.0),
      ),
      color: renk,
      onPressed: onpressed,
      padding: EdgeInsets.all(20.0),
    );
  }
}
