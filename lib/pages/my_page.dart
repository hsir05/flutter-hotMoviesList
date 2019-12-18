import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:douban/res/resources.dart';

import 'package:flustars/flustars.dart';
import 'package:fluro/fluro.dart';
import '../routers/application.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String barcode = '';
final List<Map> list = [
    {
      "icon": Icons.timer,
      "name": '修改登陆密码'
    },
    {
      "icon": Icons.timer,
      "name": '绑定手机号码'
    },
    {
      "icon": Icons.category,
      "name": '启用支付密码'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      body: ListView(
        children: <Widget>[
          _headTop(context),

          Container(
            decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            margin: EdgeInsets.all(10.0),
            child: ListTile(
            title: Text('我看过的电影'),
            leading: Icon(Icons.dashboard),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              print(333);
            },
          ),
          ),

          Container(
            decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            margin: EdgeInsets.only(left: 10.0, right: 10.0,),
            child: ListTile(
            title: Text('我收藏的电影'),
            leading: Icon(Icons.favorite),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              print(333);
            },
          ),
          )

        ],
      )
    );
  }

  Widget _headTop(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().getAdapterSize(130),
      padding: EdgeInsets.only(top: 25, bottom: 25),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            image: AssetImage("images/membg.png"),
            fit: BoxFit.cover,
          ),
        ),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){
               Application.router.navigateTo(context, "/setting", transition: TransitionType.inFromRight); 
            },
            child: Container(
            width: ScreenUtil.getInstance().getAdapterSize(60),
            height: ScreenUtil.getInstance().getAdapterSize(60),
            margin: EdgeInsets.only(left: 30.0, right: 15.0),
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.black54,
              backgroundImage: AssetImage("images/avatar.png")),
          ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('清风明月', style: TextStyles.textSize14,),
              Text('普通用户', style: TextStyles.textSize12,)
            ],
          ),
          ),
        ],
      ),
    );
  }
}
