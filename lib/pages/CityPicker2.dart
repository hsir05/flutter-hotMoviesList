import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';

class CityPicker2 extends StatefulWidget {
  @override
  _CityPicker2State createState() => _CityPicker2State();
}



class _CityPicker2State extends State<CityPicker2> {
  String province;
  String city;
  String county;

  @override
  void initState () {
    super.initState();
    // cityPicker2();
  }
  
  show() async {
    Result result = await CityPickers.showCityPicker(
      context: context,
    );
    // Result result2 = await CityPickers.showFullPageCityPicker(
    //   context: context,
    // );
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
              show();
            },
          ),
          // Text(province),
          // Text(city),
          // Text(county),
        ],),
      ),
    );
  }
}