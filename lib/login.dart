import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import 'package:douban/res/resources.dart';

// import 'package:fluwx/fluwx.dart' as fluwx;
// import 'package:flutter_qq/flutter_qq.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _forKey = GlobalKey<FormState>();
  String _phone, _password, _code;
  bool _isObscure = true;
  bool _isFree = false;
  Color _eyeColor;
  String _output = '---';
  String _verifyStr = '获取验证码';
  int _seconds = 0;
  // Time _time;

  @override
    void initState() {
    super.initState();
    // _initFluwx();

    //  fluwx.responseFromAuth.listen((data) {
      // print(data);
    // });
  }
  @override
  void dispose() {
    super.dispose();
  }
  
  // _initFluwx() async {
  //   await fluwx.register(
  //       appId: "wxd930ea5d5a258f4f",
  //       doOnAndroid: true,
  //       doOnIOS: true,
  //       enableMTA: false);
  //   var result = await fluwx.isWeChatInstalled();
  //   print("is installed $result");
  // }
  // // QQ 登陆
  // Future<Null> _handleLogin() async {
  //   print(4444);
  //   try {
  //     var qqResult = await FlutterQq.login();
  //     var output;
  //     if (qqResult.code == 0) {
  //       if(qqResult.response==null){
  //         output = "登录成功qqResult.response==null";
  //         return;
  //       }
  //       output = "登录成功" + qqResult.response.toString();
  //     } else {
  //       output = "登录失败" + qqResult.message;
  //     }
  //     setState(() {
  //       _output = output;
  //     });
  //   } catch (error) {
  //     print("flutter_plugin_qq_example:" + error.toString());
  //   }
  // }

// 验证码倒计时
_startTimer() {
     _seconds = 10;
    // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   if (_seconds == 0) {
    //     _cancelTimer();
    //     return;
    //   }

    //   _seconds--;
    //   _verifyStr = '$_seconds(s)';
    //   setState(() {});
    //   if (_seconds == 0) {
    //     _verifyStr = '重新发送';
    //   }
    // });
}
  @override
  Widget build(BuildContext context) {
    // FlutterQq.registerQQ('1109507223');
    return Scaffold(
      appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black,),
                onPressed: () {
                    Navigator.pop(context);
                }),
            title: Text('登陆', style: TextStyle(color: Colors.black), textAlign: TextAlign.left,),
            centerTitle: false,
            ),
      body: Form(
        key: _forKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          children: <Widget>[
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(20),),
            buildTitle(),
            // SizedBox(height: ScreenUtil.getInstance().getAdapterSize(20),),
            buildPhoneTextField(),
            // SizedBox(height: ScreenUtil.getInstance().getAdapterSize(10)),
            buildPasswordTextField(context),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(30)),
             buildIsFreeLoginText(),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(30)),
            buildLoginButton(context),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(30)),
            buildOtherLoginText(),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(20)),
            buildOtherMethod(context),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(30)),
            buildButton(context),
          ],
        ),
      ),
    );
  }
  //  电话号码
  TextFormField buildPhoneTextField () {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Phone',
      ),
      maxLines: 1,
      maxLength: 11,
      keyboardType: TextInputType.number,
      validator: (String value) {
        var phoneReg = RegExp(
          r"/^1(3|4|5|6|7|8|9)\d{9}$/"
        );
        if (!phoneReg.hasMatch(value)) {
           return '请输入正确的电话号码';
        }
      },
      onSaved: (String value) => _phone = value,
    );
  }

  Widget buildPasswordTextField (BuildContext context) {
    if (_isFree) {
      return TextFormField(
            onSaved: (String value) => _password = value,
            obscureText: _isObscure,
            validator: (String value) {
              if (value.isEmpty) {
                return '请输入密码';
              }
            },
            maxLines: 1,
            maxLength: 11 ,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color:_eyeColor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                    _eyeColor = _isObscure ? Colors.grey : Theme.of(context).iconTheme.color;
                  });
                },
              ),
            ),
          );
    } else {
      return Stack(children: <Widget>[
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Code',
        ),
        maxLines: 1,
        maxLength: 6,
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty) {
            return '请输入验证码';
          }
        },
        onSaved: (String value) => _code = value,
      ),
      Positioned (
        right: 0,
        bottom: 25,
        child: RaisedButton(
        //文本
        child: Text(
           '$_verifyStr',
          style: TextStyle(fontSize: 14.0),
        ),
        //按钮背景色
        color: Colors.white,
        //按钮亮度
        colorBrightness: Brightness.dark,
        //失效时的背景色
        // disabledColor: Colors.grey,
        //失效时的文本色
        // disabledTextColor: Colors.grey,
        //文本颜色
        textColor: Colors.black54,
        //按钮主题 ButtonTheme ButtonThemeData ButtonTextTheme ThemeData
        textTheme: ButtonTextTheme.normal,
        //墨汁飞溅的颜色
        splashColor: Colors.black12,
        //抗锯齿能力
        clipBehavior: Clip.antiAlias,
        //内边距
        padding: new EdgeInsets.only(
          bottom: 5.0,
          top: 5.0,
          left: 20.0,
          right: 20.0,
        ),
        shape: RoundedRectangleBorder(
          side: new BorderSide(
            width: 2.0,
            color: Colors.white,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(5.0),
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
        ),

        onPressed: () {
          print('按钮按下操作');

        },
      ),
      )
      ],);
    }
  }
  

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: ScreenUtil.getInstance().getAdapterSize(50),
        width:ScreenUtil.getInstance().getAdapterSize(370),
        child: RaisedButton(
          child: Text(
            '登陆',
            style: TextStyle(color: Colors.white, fontSize: 20.0),  
          ),
          color: Colors.redAccent,
          shape: StadiumBorder(), 
          onPressed: () {
            if (_forKey.currentState.validate()) {
              _forKey.currentState.save();
              print('phone:$_phone , assword:$_password');
            }
          },
          // shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: Text(  '豆瓣', style: TextStyle(fontSize: 42.0)),),
    );
  }
  
  Align buildIsFreeLoginText() {
    return Align(
      child: GestureDetector(
          child:  Text(_isFree ?'免密登陆' : '密码登陆', style: TextStyle(color: Colors.grey, fontSize: 14.0),),
            onTap: () => {
              setState(() {
                if (_isFree) {
                  _isFree = false;
                } else {
                  _isFree = true;
                }
              })
            } 
        ),
        
      );
  }
  
  Align buildOtherLoginText() {
    return Align(
        alignment: Alignment.center,
        child: Text(  '第三方登陆', style: TextStyle(color: Colors.grey, fontSize: 14.0)),
        );
  }
  
  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child:  Image.asset('images/weixin.png',width: 40.0, height: 40.0, fit: BoxFit.fill,),
            onTap: () => {
              // fluwx.sendAuth(fluwx.WeChatSendAuthModel(scope: 'snsapi_userinfo', state: "wechat_sdk_demo_test"))
              //   .then((data) {
              //     print(data); //true
              //   })
            } 
        ),
        Gaps.vGap16,
        Gaps.vGap16,
        Gaps.vGap16,
        GestureDetector(
          child:Image.asset('images/QQ.png',width: 40.0,
            height: 40.0,
            fit: BoxFit.fill,),
            // onTap: _handleLogin,
            onTap: (){
              print(333);
            },
        )
      ],
    );
  }

  Align buildButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
          child: Text('点击注册', style: TextStyle(color: Colors.grey, fontSize: 14.0)),
          onTap: () => {
            // showToast("Show Short Toast", gravity: Toast.TOP)
          },
          )
      );
  }

  void showToast(String msg, {int duration, int gravity}) {
    // Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
