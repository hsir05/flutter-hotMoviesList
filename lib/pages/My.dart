import 'package:flutter/material.dart';

class My extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('My'),
        backgroundColor: Colors.redAccent
      ),
      body:Center(
        child: Text('My'),
      )
    );
  }
}