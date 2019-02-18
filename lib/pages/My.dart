import 'package:flutter/material.dart';
import './Weather.dart';
import './Upload.dart';
import './Camera.dart';
import './PhoteShow.dart';
import './Publish.dart';

class My extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('我的'),
        backgroundColor: Colors.redAccent
      ),
      body: Column(
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
            leading: new Icon(Icons.wb_sunny,color: Colors.lightBlue,),
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
            leading: new Icon(Icons.image,color: Colors.lightBlue,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return PublishPage();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),

          ListTile(
            title:new Text('拍照',style: TextStyle(fontWeight: FontWeight.w500),),
            leading: new Icon(Icons.image,color: Colors.lightBlue,),
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
            leading: new Icon(Icons.image,color: Colors.lightBlue,),
            trailing: new Icon(Icons.chevron_right),
            onTap: () {
               Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return PublishTweetPage();
                }));
            },
          ),
          Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider()),
        ],
      ),);
  }
}