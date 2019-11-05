import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   @override
   _SplashScreenState createState() => _SplashScreenState();
 }
 
 class _SplashScreenState extends State {
   startTime() async {
    var _duration = Duration(seconds: 3);
      return Timer(_duration, navigationPage);
    }
 
   void navigationPage() {
     Navigator.of(context).pushReplacementNamed('hot');
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover
        )
       )
     );
   }
 }