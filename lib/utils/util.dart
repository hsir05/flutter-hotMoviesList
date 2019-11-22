import 'package:flutter/material.dart';

class Util {
 static strSplic(List list) {
   if (list != null && list.isNotEmpty) {
      String str = '';
      for (int i = 0; i<= list.length-1; i++) {
        if (i == list.length-1) {
          str += list[i];
        } else {
          str += list[i] + ' / ';
        }
      } 
      return str;
   } else{
     print('缺少参数或参数不正确');
   }
  }
}