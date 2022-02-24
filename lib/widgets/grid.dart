import 'package:flutter/material.dart';
import 'package:flutter_slide_puzzle/widgets/gridbutton.dart';

class Grid extends StatelessWidget {
  var number = [];
  var size;
  Function onclick;
  Color color;

  Grid({this.number, this.size, this.onclick, this.color});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.75,
      width: 600,
      child: Padding(
        padding: const EdgeInsets.only(left:100.0,right:100.0,top: 50.0, bottom:20.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: number.length,
          itemBuilder: (BuildContext context, int index) {
            return number[index] != 0
                ? GridButton(
                    click: () {
                      onclick(index);
                      
                    },
                    name: '${number[index]}',
                    color: color,
                  )
                : SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
