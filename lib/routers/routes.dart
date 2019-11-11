import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes{
  static String root='/';
  // static String hot = '/hot';

  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params ){
        print('错误---------->路由未找到');
      }
    );
    
    router.define(root, handler:homeHandler);
  //   router.define(hot, handler:hotHandler);
  }
}
