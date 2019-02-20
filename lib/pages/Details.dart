import 'package:flutter/material.dart';
import 'dart:io';
import 'package:amap_location/amap_location.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  void initState () {
    super.initState();
    // AMapLocationClient.setApiKey("72bb91a73f5ecec5b4227c0a29b32833");
    // getLocation();
  }

  getLocation () async{
    await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters ));
    await AMapLocationClient.getLocation(true);

    AMapLocationClient.onLocationUpate.listen((AMapLocation loc){
      if(!mounted)return;
      print('===========================================');
      print(loc);
    });

    AMapLocationClient.startLocation();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title:'Detail',
      home: Scaffold(
        appBar:AppBar(
          title: Text('Details'),
          backgroundColor: Colors.redAccent
        ),
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('detail'),
            ],
          ),
        ),
      )
    );
  }
}