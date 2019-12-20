import 'package:flutter/material.dart';
import 'package:douban/res/resources.dart';
import './routers/application.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key,this.isLogin,this.email}):super(key: key);

  final bool isLogin;
  final String email;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _forKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isObscure = true;
  Color _eyeColor;
 
 @override
  void initState () {
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // brightness: Brightness.dark,
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
          key: ValueKey("登陆"),
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight,),
            buildTitle(),
            SizedBox(height: 20.0,),
            buildEmailTextField(),
            SizedBox(height: 20.0),
            buildPasswordTextField(context),
            SizedBox(height: 50.0),
            buildLoginButton(context),
            
            SizedBox(height: 50.0),
            moreLogin()
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailTextField () {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '邮箱地址',
      ),
      validator: (String value) {
        var emailReg = RegExp(
          r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?"
        );
        if (!emailReg.hasMatch(value)) {
           return '请输入正确的邮箱地址';
        }
      },
      onSaved: (String value) => _email = value,
    );
  }

  TextFormField buildPasswordTextField (BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
        labelText: '密码',
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
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 55.0,
        width: 350.0,
        child: RaisedButton(
              color: Colors.redAccent,
              shape: StadiumBorder(), 
              child: Text( '登陆', style: TextStyle(color: Colors.white, fontSize: 16.0)),
              onPressed:(){
                login();
              },
              )
          
      ));
  }

  Widget buildTitle () {
    return Center(
      child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '豆瓣',
        style: TextStyle(color: Colors.black, fontSize: 36.0),
      ),
    ),
    );
  }

  Widget moreLogin() {
    return Center(
      child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '更多登陆方式',
        style: TextStyle(color: Colours.text_gray, fontSize:16.0),
      ),
    ),
    );
  }

  void login() async{
    print('login'); 
    if (_forKey.currentState.validate()) {
      _forKey.currentState.save();
      print('email:$_email , assword:$_password');
      Navigator.pop(context);
      // Application.router.navigateTo(context,"/");

    }
      // try {
      //   Response response;
      //   response = await Dio().get("https://www.toutiao.com/stream/widget/local_weather/data/?city=兰州");
      //   return print(response);
      // }catch(e){
      //   return print(e);
      // }
 }
}