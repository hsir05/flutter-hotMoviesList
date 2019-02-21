import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './state/state.dart';
import './pages/Splash.dart';
import './login.dart';


void main() {
   Store<AppState> store = new Store<AppState>(mainReducer,initialState: new AppState(
    main: new MainPageState(),
    auth: new AuthState(),
  ),middleware: [loggingMiddleware]);
  runApp(new MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp(this.store);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
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