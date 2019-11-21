import "package:dio/dio.dart";
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future request(url, formData, {type: 'get'})async{
    try{
      print('$url, 开始获取数据...............');
      Response response;
      Dio dio = new Dio(); 
      dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");

      if(type == 'get'){  
        var urlList = url.split('?');
       
        if (urlList.length == 1) {
          response = await dio.get(servicePath[urlList[0]], queryParameters: formData);
        } else {
          response = await dio.get(servicePath[urlList[0]] + '/${urlList[1]}', queryParameters: formData);
        }
        // response = await dio.get(servicePath[url] + '?city=%E5%8C%97%E4%BA%AC&start=${formData['start']}&count=${formData['count']}&apikey=0b2bdeda43b5688921839c8ecb20399b');
        // response = await dio.get(servicePath[url], queryParameters: formData);

      }else{
        response = await dio.post(servicePath[url], data:formData);
      }
      if(response.statusCode==200){
        return response.data;
      }else{
          throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }catch(e){
        return print('ERROR:---------->$e');
    }
}

Future requestGet(url,data)async{
    try{
      print('$url, 开始获取数据...............');
      Response response;
      Dio dio = new Dio();
      dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");

      response = await dio.post(servicePath[url] + '/subject/$data' + '?apikey=0b2bdeda43b5688921839c8ecb20399b');

      if(response.statusCode==200){
        return response.data;
      }else{
          throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }catch(e){
        return print('ERROR:---------->$e');
    }
}