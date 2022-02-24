import 'package:flutter/material.dart';

class HintButton extends StatelessWidget {
  Function undo;
  HintButton({this.undo});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: undo,
      color: Colors.blue[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
