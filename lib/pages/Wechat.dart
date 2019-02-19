import 'package:flutter/material.dart';
// import 'package:fluwx/fluwx.dart' as fluwx;

class Wechat extends StatefulWidget {
  @override
  _WechatState createState() => _WechatState();
}

class _WechatState extends State<Wechat> {

  // @override
  // void initState () {
  //   fluwx.registerApp(RegisterModel(appId: "wxd930ea5d5a258f4f", doOnAndroid: true, doOnIOS: true));
  // }

  // void share () {
  //   fluwx.share(WeChatShareTextModel(
  //     text: "text from fluwx",
  //     transaction: "transaction}",//仅在android上有效，下同。
  //     scene: scene
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('微信'),
        backgroundColor: Colors.redAccent
      ),
      body:Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Center(
          child: Column(children: <Widget>[
            RaisedButton(
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 50.0,right: 50.0),
                child: Text('分享',style: TextStyle(color: Colors.white,fontSize: 18.0),),
              ),
              onPressed: () {
                print('分享2');
                // share();
              },
            )
          ]),
        ),
      ));
  }
}