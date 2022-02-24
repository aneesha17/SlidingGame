import 'package:flutter/material.dart';
import 'package:flutter_slide_puzzle/src/board.dart';
import 'dart:math';

class GameMenu extends StatelessWidget {
  Random random1 = new Random(),
          random2 = new Random(),
            random3 = new Random(),
              random4 = new Random(),
                random5 = new Random(),
                  random6 = new Random(),
                    random7 = new Random(),
                      random8 = new Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(random1.nextInt(256), random2.nextInt(256), random3.nextInt(256), random4.nextInt(256)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
               
                child: Image(
                  image: AssetImage('assets/logo1.png'),
                  height: 500,
                  width: 500,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(random5.nextInt(256), random6.nextInt(256), random7.nextInt(256), random8.nextInt(256)),
                      borderRadius: BorderRadius.circular(70),
                      boxShadow: [
                        shadow(),
                      ]),
                  child: IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 70,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (BuildContext context, _, __) =>
                              Board()));
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),

              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: Colors.pinkAccent,
                        boxShadow: [
                          shadow(),
                        ]),
                    child: IconButton(
                        icon: Icon(
                          Icons.help_center,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {}),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: Colors.pinkAccent,
                        boxShadow: [
                          shadow(),
                        ]),
                    child: IconButton(
                        icon: Icon(
                          Icons.list,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {}),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: Colors.pinkAccent,
                        boxShadow: [
                          shadow(),
                        ]),
                    child: IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {}),
                  ),
                ],
              ),*/

            ],
          ),
        ),
      ),
    );
  }

  BoxShadow shadow() {
    return BoxShadow(
      color: Colors.black45,
      blurRadius: 5,
      spreadRadius: 1,
      offset: Offset(0, 10.0),
    );
  }
}
