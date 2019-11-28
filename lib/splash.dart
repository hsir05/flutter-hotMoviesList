import 'dart:async';
import 'package:flutter/material.dart';
import './routers/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    //设置启动图生效时间
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  } 

  void navigationPage() {
      Application.router.navigateTo(context,"/", transition: TransitionType.inFromRight);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/splash.webp', fit: BoxFit.cover, height: ScreenUtil.getInstance().screenHeight,),
      ),
    );
  }
}