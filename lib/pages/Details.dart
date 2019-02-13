import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Details'),
        backgroundColor: Colors.redAccent
      ),
      body:Center(
        child: Text('Details'),
      )
    );
  }
}