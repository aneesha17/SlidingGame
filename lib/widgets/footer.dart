import 'package:flutter/material.dart';
import 'package:flutter_slide_puzzle/src/gamemenu.dart';
import 'package:flutter_slide_puzzle/widgets/resetbutton.dart';
import 'package:flutter_slide_puzzle/widgets/hintbutton.dart';

class FooterButton extends StatelessWidget {
  Function reset,hint;
  FooterButton({this.reset, this.hint});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:0 ,left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.height*0.1,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 10.0),
                    color: Colors.black45,
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]),
            child: IconButton(
              icon: Icon(
                Icons.lightbulb_outline_rounded ,
                color: Colors.pinkAccent[900],
                size: 40,
              ),
               onPressed: hint,
            ),
          ),Container(
            width: MediaQuery.of(context).size.height*0.1,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 10.0),
                    color: Colors.black45,
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]),
            child: IconButton(
              icon: Icon(
                Icons.undo,
                color: Colors.pinkAccent[900],
                size: 40,
              ),
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (BuildContext context, _, __) => GameMenu()));
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.height*0.1,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 10.0),
                    color: Colors.black45,
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Colors.pinkAccent[900],
                size: 40,
              ),
             onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (BuildContext context, _, __) => GameMenu()));
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.height*0.1,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 10.0),
                    color: Colors.black45,
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.pinkAccent[900],
                size: 40,
              ),
              onPressed: reset,
            ),
          ),
        ],
      ),
    );
  }

}
