import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './Home.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './state/state.dart';

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
      body: Form(
        key: _forKey,
        child: ListView(
          key: ValueKey("login"),
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            SizedBox(height: kToolbarHeight,),
            buildTitle(),
            buildTitleLine(),
            SizedBox(height: 70.0,),
            buildEmailTextField(),
            SizedBox(height: 30.0),
            buildPasswordTextField(context),
            SizedBox(height: 30.0),
            buildLoginButton(context),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailTextField () {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email Address',
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
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: StoreConnector<AppState,VoidCallback>(
          key: ValueKey("logout"),
          builder: (BuildContext context,VoidCallback login){
            return RaisedButton(
              color: Colors.redAccent,
              shape: StadiumBorder(), 
              child: Text(
                'Login',style: Theme.of(context).primaryTextTheme.headline,
              ),
              onPressed:login,
              );
          }, 
          converter: (Store<AppState> store){
            return ()=>
              login(store);
          })
      ));
  }

   Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 110.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle () {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  void login(store) async{
    print('login'); 
    // if (_forKey.currentState.validate()) {
    //   _forKey.currentState.save();
    //   print('email:$_email , assword:$_password');
    //   store.dispatch(
    //     LoginSuccessAction(email: '123123@qq.com')
    //   );
    //   Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
    //     return BottomNavigationWidget();
    //   }));
    // }
     store.dispatch(
        LoginSuccessAction(email: '123123@qq.com')
      );
      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
        return BottomNavigationWidget();
      }));
      // try {
      //   Response response;
      //   response = await Dio().get("https://www.toutiao.com/stream/widget/local_weather/data/?city=兰州");
      //   return print(response);
      // }catch(e){
      //   return print(e);
      // }
 }
}