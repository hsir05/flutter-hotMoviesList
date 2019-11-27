import 'package:flutter/material.dart';

class Location with ChangeNotifier {
    var location = {"cityName":"北京城区","cityId":"110100"};

    getLocation(data){
      location = data;
      notifyListeners();
    }
}