import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes{
  static String root='/'; 
  static String login='/login'; 
  static String movieDetail = '/movieDetail';  
  static String trailerVideo = '/trailerVideo';
  static String celeBrity = '/celeBrity';

  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params ){
        print('错误---->路由未找到');
      }
    );
    
    router.define(root, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.define(movieDetail, handler: movieDetailHandler);
    router.define(trailerVideo, handler: trailerVideoPlayHandler);
    router.define(celeBrity, handler: celeBrityPageHandler);
  }
}
