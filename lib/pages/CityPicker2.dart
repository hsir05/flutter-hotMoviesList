import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../component/AttrItemContainer.dart';

class CityPicker2 extends StatefulWidget {
  @override
  _CityPicker2State createState() => _CityPicker2State();
}

class _CityPicker2State extends State<CityPicker2> {
  Result result = new Result();
  
  show() async {
    Result res = await CityPickers.showCityPicker(
      context: context,
    );
    setState(() {
     result = res;
    });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('城市选择'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('城市选择器'),
          ),
          AttrItemContainer(
              title: '选择结果',
              editor: Text("${result.toString()}")
          ),
          RaisedButton(
            child: Text('选择城市',style: TextStyle(color: Colors.white),),
            color: Colors.redAccent,
            onPressed: () {
              show();
            },
          ),
        ],),
      ),
    );
  }
}
