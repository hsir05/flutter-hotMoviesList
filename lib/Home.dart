import 'package:flutter/material.dart';
import 'pages/Hot.dart';
import 'pages/Details.dart';
import 'pages/My.dart';

class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _BottomNavigationColor = Colors.redAccent;
  int _currentIndex = 0;
  List<Widget> list = List();
  @override
  void initState(){
    list
      ..add(Hot())
      ..add(Details())
      ..add(My());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: list[_currentIndex],
       bottomNavigationBar: Offstage(
          offstage: false, //这里控制底部按钮显示与隐藏的方法
          child: BottomNavigationBar(
            items: [
            BottomNavigationBarItem(
              icon:Icon(
                Icons.home,
                color:_BottomNavigationColor,
              ),
              title:Text(
                'Hot',
                style:TextStyle(color:_BottomNavigationColor)
              )
            ),
            BottomNavigationBarItem(
              icon:Icon(
                Icons.pages,
                color:_BottomNavigationColor,
              ),
              title:Text(
                'Details',
                style:TextStyle(color:_BottomNavigationColor)
              )
            ),
            BottomNavigationBarItem(
              icon:Icon(
                Icons.person,
                color:_BottomNavigationColor,
              ),
              title:Text(
                'My',
                style:TextStyle(color:_BottomNavigationColor)
              )
            ),
          ],
          currentIndex:_currentIndex,
          onTap:(int index){
            setState((){
              _currentIndex= index;
            });
          },
          type:BottomNavigationBarType.fixed
         ),
        )
     );
  }
}