// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:math';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slide_puzzle/widgets/footer.dart';
import 'package:flutter_slide_puzzle/widgets/grid.dart';
import 'package:flutter_slide_puzzle/widgets/menu.dart';
import 'package:flutter_slide_puzzle/widgets/tile.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<int> num = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  String s;
  List<List> mat;
  var target = "123456789ABCDEF0";
  int move = 0;
  int second = 0;
  int i;
  int j;
  Color color;
  Timer timer;
  static const duration = const Duration(seconds: 1);
  bool isActive = false;
  int flag=0;
  int lastIndex=-1;

  @override
  void initState() {
    super.initState();
    num.shuffle();
    s=num2str(num);
    mat=str2mat(s);
    int p=num.indexOf(0);
		i=(p/4).floor()+1;
		j=p%4+1;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
      Random random1 = new Random(),
          random2 = new Random(),
            random3 = new Random(),
              random4 = new Random();
    if (timer == null) {
      timer = Timer.periodic(duration, (timer) {
        startTimer();
      });
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          color: Color.fromARGB(random1.nextInt(256), random2.nextInt(256), random3.nextInt(256), random4.nextInt(256)),
          child: Column(
            children: <Widget>[
              MyTile(
                size: size,
              ),
              Menu(
                move: move,
                second: second,
              ),
              /*SizedBox(
                height: 100,
              ),*/
              Grid(
                number: num,
                size: size,
                onclick: clickonGrid,
                color: Colors.white,
              ),
              FooterButton(
                reset: OnReset,
                hint: OnHint,
                undo:OnUndo,
              )
            ],
          ),
        ),
      ),
    );
  }

  void clickonGrid(index) {
    if (second == 0) {
      isActive = true;
    }

    if (index - 1 >= 0 && num[index - 1] == 0 && index % 4 != 0 /*To left*/ ||
        index + 1 < 16 &&
            num[index + 1] == 0 &&
            (index + 1) % 4 != 0 /*To right*/ ||
        index + 4 < 16 && num[index + 4] == 0 /*To bottom*/ ||
        index - 4 >= 0 && num[index - 4] == 0 /*To top*/) {
      setState(() {
        lastIndex=num.indexOf(0);
        num[num.indexOf(0)] = num[index];
        num[index] = 0;
        move++;
        s=num2str(num);
        mat=str2mat(s);
        int p;
        for(int r=0;r<16;r++)
        {
          if(s.codeUnitAt(r)=='0'.codeUnitAt(0))
          {
            p=r;
            break;
          }
        }
        
        i=(p/4).floor()+1;
        j=p%4+1;
    

          });
        }

    checkIfwin();
  }

  void OnReset() {
    setState(() {
      num.shuffle();
      move = 0;
      isActive = false;
      second = 0;
    });
  }

  void startTimer() {
    if (isActive) {
      setState(() {
        second++;
      });
    }
  }

  bool isSort(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkIfwin() {
    if (isSort(num)) {
      isActive = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You win',
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
  }
  
  void OnHint ()
  {
    Map<String, int> memo;
    int m = 4, n = 4;
    int i1=i-1;
    int j1=j-1;
    String hash = "123456789ABCDE0";
    int  mini = double.maxFinite.ceil();
    List<List>  dir = [[0, -1], [0, 1], [-1, 0], [1, 0]];
    String curr=s;

    List<Pair<Pair<int, int>, Pair<List<List>,String>>> ver;
    ver.add(Pair(Pair(i1, j1), Pair(mat,curr)));
    memo[curr] = 0;
    int flag=0;
    String ans=s;
    while (ver.isNotEmpty) 
    {
      i = ver[0].first.first;
      j = ver[0].first.last;
      mat = ver[0].last.first;
      String ls=ver[i1].last.last;
      ver.removeAt(0);
      String val = mat2str(mat);
      if (val==hash)   
      {
        if(mini>memo[val])
        {
          ans=ls;
          }
        mini = min(mini, memo[val]);
        continue;
      }
      for (int d = 0; d < 4; d++) 
      {
        int x = i1 + dir[d][0], y = j1 + dir[d][1];
        if (x >= 0 && x < m && y >= 0 && y < n) 
        {
          List<List> b = mat;
          var temp=b[i1][j1];
          b[i1][j1]=b[x][y];
          b[x][y]=temp;                    
          String v = mat2str(b);
          if (!memo.containsKey(v) || memo[v] > memo[val] + 1) 
          {
            memo[v] = memo[val] + 1;
            if(flag==0)
            {
              ver.add(Pair(Pair(x, y), Pair(b,v)));
            }
            else
            ver.add(Pair(Pair(x, y), Pair(b,ls)));
          }
        }
      }          
      flag++; 
    }
    int p;
    for(int r=0;r<16;r++)
    {
      if(ans.codeUnitAt(r)=='0'.codeUnitAt(0))
      {
        p=r;
        break;
      }
    }
    print(p);
  }

  void OnUndo() 
  {

    clickonGrid(lastIndex);

  }
}

List<List> str2mat(String s) {
  List<List> ans=[];
	int index = 0;
	for(int i = 0; i < 4; i++)
  {  var an=[];
		for(int j = 0; j < 4; j++)
      {
        if (s.codeUnitAt(index)=='A'.codeUnitAt(0))
        an.add(10);
        else if (s.codeUnitAt(index)=='B'.codeUnitAt(0))
        an.add(11);
        else if (s.codeUnitAt(index)=='C'.codeUnitAt(0))
        an.add(12);
        else if (s.codeUnitAt(index)=='D'.codeUnitAt(0))
        an.add(13);
        else if (s.codeUnitAt(index)=='E'.codeUnitAt(0))
        an.add(14);
        else if (s.codeUnitAt(index)=='F'.codeUnitAt(0))
        an.add(15);      
        else
        an.add(int.parse(s[index]));
        index++;
      }
      ans.add(an);
  }
	return ans;

}

String mat2str(List<List> board) {
  String res="";
  for(int i=0;i<4;i++)
  {
    for(int j=0;j<4;j++)
    {
      if(board[i][j]==10)
      res+='A';
      else if(board[i][j]==11)
      res+='B';
      else if(board[i][j]==12)
      res+='C';
      else if(board[i][j]==13)
      res+='D';
      else if(board[i][j]==14)
      res+='E';
      else if(board[i][j]==15)
      res+='F';
      else
      res+=board[i][j].toString();
    }
  }
  return res;
}


String num2str(List<int> num) {
  String s="";
  for(int i=0;i<num.length;i++)
  {
    if(num[i]<10)
    s+=num[i].toString();
    else if(num[i]==10)
    s+='A';
    else if(num[i]==11)
    s+='B';
    else if(num[i]==12)
    s+='C';
    else if(num[i]==13)
    s+='D';
    else if(num[i]==14)
    s+='E';
    else if(num[i]==15)
    s+='F';
  }
  return s;  
}
