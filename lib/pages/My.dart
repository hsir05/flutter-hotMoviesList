import 'package:flutter/material.dart';
import './Weather.dart';
import './Refresh.dart';
import './Camera.dart';
import './PhoteShow.dart';
import './Publish.dart';
import './CityPcker1.dart';
import './CityPicker2.dart';
import './wechat/Wechat.dart';
import './WebView.dart';
import './DatePicker.dart';
import './ContactPicker.dart';
import './reduce/ReduceExam.dart';

class My extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('我的'),
        backgroundColor: Colors.redAccent
      ),
      body:ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:10.0,left: 10.0,bottom: 10.0),
            alignment: Alignment.bottomLeft,
            child: Row(
              children: <Widget>[
                ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: "images/0.jpg",//预览图
                    fit: BoxFit.fitWidth,
                    image:"images/001.jpg",
                    width: 60.0,
                    height: 60.0,
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10.0,),
                  child: Text('假装有昵称',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,),))
              ],
            ),),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          ListTile(
            title:new Text('天气预报',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.wb_sunny,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return new Weather();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          ListTile(
            title:new Text('文字图片',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.image,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return PublishPage();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          ListTile(
            title:new Text('日期',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.date_range,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return DatePicker();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),
          ListTile(
            title:new Text('ReduceExam',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.airline_seat_legroom_reduced,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return TopScreen();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

           ListTile(
            title:new Text('联系人',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.contact_phone,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return ContactPicker();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          ListTile(
            title:new Text('拍照',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.fastfood,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return Camera();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

           ListTile(
            title:new Text('相册照片选取展示',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.group_work,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return PublishTweetPage();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          ListTile(
            title:new Text('下拉刷新，上拉加载',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.music_video,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return RefreshListPage();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          ListTile(
            title:new Text('城市选择1',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.photo_album,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return CityPicker();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          ListTile(
            title:new Text('城市选择2',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.code,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return CityPicker2();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          ListTile(
            title:new Text('微信',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.chat_bubble_outline,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return WechatShare();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          ListTile(
            title:new Text('WebView',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.chat_bubble_outline,color: Colors.redAccent,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                return NewsWebPage('https://www.baidu.com/','baidu');
              }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          // ListTile(
          //   title:new Text('日期插件',style: TextStyle(fontWeight: FontWeight.w500),),
          //   leading: new Icon(Icons.date_range,color: Colors.redAccent,),
          //   trailing: new Icon(Icons.chevron_right),
          //   onTap: () {
          //     Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
          //       return NewsWebPage('https://www.baidu.com/','baidu');
          //     }));
          //   },
          // ),
          // Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),
        ],
      ),);
  }
}