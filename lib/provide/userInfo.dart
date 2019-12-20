import 'package:flutter/material.dart';

class UserInfo with ChangeNotifier {
   bool isLogin = false;
   Map userInfo = {};

    login(data){
      userInfo = data;
      isLogin = true;
      notifyListeners();
    }

    loginOut() {
      userInfo = {};
      isLogin = false;
        notifyListeners();
    }
}