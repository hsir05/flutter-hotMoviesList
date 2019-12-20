import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provide/provide.dart';
import 'package:flutter/services.dart';
import 'index_page.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './provide/theme.dart';
import './provide/location.dart';
import './provide/userInfo.dart';
// import './splash.dart';


void main() async{
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
 
  var themer = Themer();
  var location = Location();
  var userInfo = UserInfo();
  var providers  =Providers();
  providers
    ..provide(Provider<Themer>.value(themer))
    ..provide(Provider<Location>.value(location))
    ..provide(Provider<UserInfo>.value(userInfo));

  runApp(ProviderNode(child:MyApp(), providers:providers));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.configureRoutes(router);
    Application.router=router;

     return Provide<Themer>(
      builder: (context,child,theme){
          return MaterialApp(
            title:'豆瓣',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Application.router.generator,
            theme: theme.getTheme(),
            darkTheme: theme.getTheme(isDarkMode: true),
            // home:SplashScreen()
            home:IndexPage()
        );
      }
    );
  }
}