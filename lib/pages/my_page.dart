import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
// import '../state/state.dart';

// import './Weather.dart';
// import './Refresh.dart';
// import './Camera.dart';
// import './PhoteShow.dart';
// import './Publish.dart';
// import './CityPcker1.dart';
// import './CityPicker2.dart';
// import './wechat/Wechat.dart';
// import './WebView.dart';
// import './DatePicker.dart';
// import './ContactPicker.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }
}
// class MyPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, AuthState>(
//       converter: (Store<AppState> store) => store.state.auth,
//       builder: (BuildContext context, auth) {
//         return Scaffold(
//           appBar:AppBar(
//             title: Text('我的'),
//             backgroundColor: Colors.redAccent
//           ),
//           body:ListView(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(top:10.0,left: 10.0,bottom: 10.0),
//                 alignment: Alignment.bottomLeft,
//                 child: Row(
//                   children: <Widget>[
//                     avator(),
//                     Padding(padding: EdgeInsets.only(left: 10.0,),
//                       child: Text(
//                         auth.email,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,)))
//                   ],
//               )),
//               line(),

//               listTile(context,'天气预报', Icons.wb_sunny, Weather()),
//               line(),

//               listTile(context,'文字图片', Icons.image, PublishPage()),
//               line(),

//               listTile(context,'日期', Icons.date_range, DatePicker()),
//               line(),

//               listTile(context,'联系人', Icons.contact_phone, ContactPicker()),
//               line(),

//               listTile(context,'拍照', Icons.fastfood, Camera()),
//               line(),

//               listTile(context,'相册照片选取展示', Icons.group_work, PublishTweetPage()),
//               line(),

//               listTile(context,'下拉刷新，上拉加载', Icons.music_video, RefreshListPage()),
//               line(),

//               listTile(context,'城市选择1', Icons.photo_album, CityPicker()),
//               line(),

//               listTile(context,'城市选择2', Icons.code, CityPicker2()),
//               line(),

//               listTile(context,'微信', Icons.chat_bubble_outline, WechatShare()),
//               line(),

//               listTile(context,'WebView', Icons.chat_bubble_outline, NewsWebPage('https://www.baidu.com/','baidu')),
//               line(),
              
//             ],
//         ));
//       });
//   }

//   Widget listTile (context, title, icon,widgetName) {
//     return ListTile(
//       title: Text(title,style: TextStyle(fontWeight: FontWeight.w500),),
//       leading:  Icon(icon,color: Colors.redAccent,),
//       trailing:  Icon(Icons.chevron_right),
//       onTap: () {
//         Navigator.push(context,  MaterialPageRoute(builder: (BuildContext context){
//             return  widgetName;
//         }));
//       },
//     );
//   }

//   Widget avator () {
//     return ClipOval(
//       child: FadeInImage.assetNetwork(
//         placeholder: "images/0.jpg",//预览图
//         fit: BoxFit.fitWidth,
//         image:"images/001.jpg",
//         width: 60.0,
//         height: 60.0,
//       ),
//     );
//   }

//   Padding line () {
//     return Padding(padding: EdgeInsets.only(left:15.0,right: 15.0),child: Divider());
//   }
// }