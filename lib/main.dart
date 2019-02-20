import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './state/count_state.dart';
import './pages/Splash.dart';
import './login.dart';


void main() {
  final store =
      Store<CountState>(reducer, initialState: CountState.initState());
  runApp(new MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<CountState> store;

  MyApp(this.store);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<CountState>(
      store: store,
      child: MaterialApp(
        title:'Login',
        theme:ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home:SplashScreen(),
        routes: {
          'Login': (BuildContext context) => LoginPage()
        },
      )
    );
  }
}