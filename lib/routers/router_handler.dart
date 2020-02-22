import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../index_page.dart';
import '../login.dart';
import '../pages/moviesDetail_page.dart';
import '../pages/trailerVideoPlay_page.dart';
import '../pages/celebrity_page.dart';

Handler homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return IndexPage();
});
 
Handler loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return LoginPage();
});

Handler movieDetailHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  String id = params['id'].first;
  return MoviesDetailPage(id: id);
});

Handler trailerVideoPlayHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  String id = params['id'].first;
  return TrailerViderPlayPage(id: id);
});

Handler celeBrityPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  String id = params['id'].first;
  return CeleBrityPage(id: id);
});

