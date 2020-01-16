import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  Message(this.title, this.message, this.callback);
  final title;
  final message;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: callback,
          color: Colors.grey,
          child: Text('Reset'),
        )
      ],
    );
  }
}
