import 'package:flutter/material.dart';
import 'package:city_picker/city_picker.dart';
import 'dart:convert';

class CityPicker extends StatefulWidget {
  @override
  _CityPickerState createState() => _CityPickerState();
}



class _CityPickerState extends State<CityPicker> {
  String province;
  String city;
  String county;

  @override
  void initState () {
    super.initState();
  }
  
  cityPicker () async {
    CityResult result = await showCityPicker(context);
    setState(() {
      province = result?.province; // 省
      city = result?.city; // 市
      county = result?.county; // 地级市/县
    });
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
          Text('城市选择器'),
          RaisedButton(
            child: Text('选择城市',style: TextStyle(color: Colors.white),),
            color: Colors.redAccent,
            onPressed: () {
              cityPicker();
            },
          ),
          Text(json.encode(province)),
          Text(json.encode(city)),
          Text(json.encode(county)),
        ],),
      ),
    );
  }
}