import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   @override
   _SplashScreenState createState() => new _SplashScreenState();
 }
 
 class _SplashScreenState extends State {
   startTime() async {
     //设置启动图生效时间
    var _duration = Duration(seconds: 10);
      return Timer(_duration, navigationPage);
    }
 
   void navigationPage() {
     Navigator.of(context).pushReplacementNamed('Login');
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
        child: Image(
          image: AssetImage('images/timg.jpg'),
          // 图片充满手机
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover
        )
       )
     );
   }
 }