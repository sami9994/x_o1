import 'package:flutter/material.dart';

class Button {
  final int index;
  String text;
  Color maincolor;
  bool enabled;

  Button(
      {this.index,
      this.text = "",
      this.maincolor = Colors.lightBlue,
      this.enabled = true});
}
