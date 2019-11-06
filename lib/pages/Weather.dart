import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
// import '../utils/http.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var weatherInfo;
  List weatherItem = [];

  @override
  void initState () {
    super.initState();
    getHttp();
  }
  void getHttp() async{
    // try {
    //   var result = await Http().get("http://wthrcdn.etouch.cn/weather_mini?city=兰州市",data: {});
    //   var res = json.decode(result);
    //   if (res['status'] == 1000) {
    //     setState(() {
    //       weatherInfo = res['data'];
    //       weatherItem = res['data']['forecast'];
    //     });
    //   }
    // }catch(e){
    //   return print(e);
    // }
  }

  getCurr () {
    if (weatherInfo != null) {
      return Column(
        children: <Widget>[
          Text(weatherInfo['city'],
                style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.w700,color: Colors.white),),
          Text(weatherInfo['ganmao'],
                style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,color: Colors.white),)
        ],
      );
    } else {
      return CupertinoActivityIndicator();
    }
  }

  getScrItem (var item) {
    var itemDetails = item;
    return Column(
      children: <Widget>[
        Container(
          height: 50.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(itemDetails['date']),
              )),
              Expanded(
                child: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(itemDetails['type']),
              ),),
              Expanded(
                child: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text('${itemDetails['high']}~${itemDetails['low']}'),
              ))
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  getScroll () {
    if (weatherItem.length != 0) {
      return ListView.builder(
        itemCount: weatherItem.length,
        itemBuilder: (BuildContext context, int item) {
          return getScrItem(weatherItem[item]);
        });
    } else {
      return CupertinoActivityIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:AppBar(
        title: Text('天气预报'),
        backgroundColor: Colors.redAccent
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: width,
              height: height/3,
              padding: EdgeInsets.only(top: 20.0,left: 15.0,right: 15.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xffd1c6f3), Color(0xFFdcc1d2), Color(0xFFe8bdb0)], 
                          begin: FractionalOffset(1, 0), end: FractionalOffset(1, 1))
              ),
              child: Center(
                child: getCurr()
              ),
            ),
            Container(
              width: width,
              height: height/2,
              padding: EdgeInsets.only(left: 15.0),
              child: getScroll()
            )
          ],
      ),)
    );
  }
}


