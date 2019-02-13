import 'package:flutter/material.dart';
// import './DouBanMovies.dart';
import './Home.dart';

// void main () => runApp(DouBanMovies());

void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flutter bottomNavigationBar',
      theme:ThemeData.light(),
      home:BottomNavigationWidget()
    );
  }
}