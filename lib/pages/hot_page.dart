import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'dart:async';
import 'dart:convert';
import '../model/hot_model.dart';
import '../service/service_method.dart';

class HotPage extends StatefulWidget {
  _HotPageState createState() => _HotPageState();
}
 
class _HotPageState extends State<HotPage>with AutomaticKeepAliveClientMixin  {
  List hot = [];
   List<Subject> list;
  String title = '热映';

  @override
  bool get wantKeepAlive =>true;
  void initState() {
      super.initState();
  }
 
   Future _getData(){
    return request('hotPageContext', null); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
           future: _getData(),
           builder: (context, snapshot) {
             if(snapshot.hasData) {
                 var resultList = snapshot.data['subjects'];
                  setState(() {
                    list =resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
                  });          
                return EasyRefresh(
                 footer: MaterialFooter(),
                 header: MaterialHeader(),
                //  child: _wrapList(context, list),
                 child: Container(child: Center(child: Text('data'),),),
                onLoad: ()async{
                    print('开始加载更多');
                    var timer;
                      timer = Timer.periodic(
                        const Duration(milliseconds: 2000), (Void) {
                          request('hotPageContext', null).then((data){
                              print('加载成功');
                              print('+++++++==================');
                          });
                          (timer as Timer).cancel();
                      });
                  }
                );
             } else {
               return Container(
                 child: Center( child: CupertinoActivityIndicator()),
               );
             }
        }
      )
    );
  }
  
  Widget _wrapList(BuildContext context, list) {
    print('=========list========');
    print(list.length);
    if (list.length!= 0){
      List<Widget>listWidget = list.map((val){
          return getItem(val);
      }).toList();
       return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }
  }

  getItem(var subject) {
    var avatars = List.generate(subject['casts'].length, (int index) =>
        Container(
          margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 16.0),
          child: 
          CircleAvatar(
              backgroundColor: Colors.white10,
              backgroundImage: 
              subject['casts'][index]['avatars'] == null ?  AssetImage("assets/images/avatar.png") : NetworkImage( 
                subject['casts'][index]['avatars']['small'] 
              )
          ),
        ),
    );
    var row = Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              subject['images']['large'],
              width: 100.0, height: 150.0,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
               child: Container(
                margin: EdgeInsets.only(left: 8.0),
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 电影名称
                    Text(
                      subject['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      maxLines: 1,
                    ),
//                    豆瓣评分
                    Text(
                      '豆瓣评分：${subject['rating']['average']}',
                      style: TextStyle(
                          fontSize: 16.0
                      ),
                    ),
//                    类型
                    Text( "类型：${subject['genres'].join("、")}" ),
//                    导演
                    Text( '导演：${subject['directors'][0]['name']}' ),
//                    演员
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text('主演：'),
                          Row(children: avatars,)
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
    return GestureDetector(
      child: Card(
        child: row,
      ),
      onTap: () {
     print('link');
      },
    );
  }


  Widget _getRow(BuildContext context, int index) {
    if (index < hot.length) {
      return getItem(hot[index]);
    }
    return _getMoreWidget();
  }

  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                '加载中...',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

}