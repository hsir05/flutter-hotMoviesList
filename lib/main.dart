import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:fluro/fluro.dart';
import 'index_page.dart';
import './routers/routes.dart';
import './routers/application.dart';

import './state/state.dart';


void main() {
   Store<AppState> store = new Store<AppState>(mainReducer,initialState: new AppState(
    main: new MainPageState(),
    auth: new AuthState(),
  ),middleware: [loggingMiddleware]);
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp(this.store);
  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.configureRoutes(router);
    Application.router=router;

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title:'豆瓣', 
        theme:ThemeData.light(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,
        home:IndexPage()
      )
    );
  }
}