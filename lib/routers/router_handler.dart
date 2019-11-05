import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../index_page.dart';
import '../pages/hot_page.dart';

Handler homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return IndexPage();
});

Handler hotHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>>params) {
  return HotPage();
});
