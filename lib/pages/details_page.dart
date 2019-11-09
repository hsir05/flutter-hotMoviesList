import 'package:flutter/material.dart';
import 'dart:io';
import 'package:amap_location/amap_location.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  void initState () {
    super.initState();
    // AMapLocationClient.setApiKey("72bb91a73f5ecec5b4227c0a29b32833");
    // getLocation();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
      );
  }
}