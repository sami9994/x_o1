import 'package:flutter/material.dart';

class Button {
  final int id;
  String text;
  Color bg;
  bool enabled;

  Button(
      {this.id,
      this.text = "",
      this.bg = Colors.lightBlue,
      this.enabled = true});
}
