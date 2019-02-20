import 'package:flutter/material.dart';
import './under_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../state/count_state.dart';

class TopScreen extends StatefulWidget {
  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Top Screen'),
      ),
      body: Center(
        child: StoreConnector<CountState,int>(
          converter: (store) => store.state.count,
          builder: (context, count) {
            return Text(
              count.toString(),
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            return UnderScreen();
          }));
        },
        child: Icon(Icons.forward),
      ),
    );
  }
}