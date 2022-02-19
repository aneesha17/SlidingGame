import 'package:flutter/material.dart';

class HintButton extends StatelessWidget {
  Function hint;
  HintButton({this.hint});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: hint,
      color: Colors.blue[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        'New Game',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
