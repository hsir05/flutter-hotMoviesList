import 'package:flutter/material.dart';

class ContactPicker extends StatefulWidget {
  @override
  _ContactPickerState createState() => _ContactPickerState();
}

class _ContactPickerState extends State<ContactPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('获取联系人插件'),
        backgroundColor: Colors.redAccent
      ),
      body: Container(
        child: Center(
          child: Column(children: <Widget>[
            RaisedButton(
              child: Text('获取联系人',style: TextStyle(color: Colors.white),),
              color: Colors.redAccent,
              onPressed: () {
                print('获取联系人');
              },
            ),
          ],),
        ),
      ));
  }
}