import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import './utils/http.dart';
import './MoviesDetails.dart';

class DouBanMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '豆瓣电影',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      home: MyHomeApp(title: 'Movies'),
    );
  }
}

class MyHomeApp extends StatefulWidget {
  final String title;

  MyHomeApp({Key key, this.title}):super(key:key);

  @override
  _MyHomeAppState createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  List subjects = [];
  String title = '';

  @override
  void initState () {
    super.initState();
    getHttp();
  }
  void getHttp() async{
      try {
       var result = await Http().get("/in_theaters",data: {});
       print(result);
       setState(() {
        title = result['title'];
        subjects = result['subjects'];
      });
      }catch(e){
        return print(e);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('热门电影'),
      ),
      body: Center(
        child: getBody(),
      ),
    );
  }
  
  getItem(var subject) {
//    演员列表
    var details = subject;
    var avatars = List.generate(subject['casts'].length, (int index) =>
        Container(
          margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 16.0),
          child: CircleAvatar(
              backgroundColor: Colors.white10,
              backgroundImage: NetworkImage(
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
//                    电影名称
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
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
          return new MoviesDetails(details:details);
        }));
      },
    );
  }

  getBody() {
    if (subjects.length != 0) {
      return ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int position) {
            return getItem(subjects[position]);
          });
    } else {
      // 加载菊花
      return CupertinoActivityIndicator();
    }
  }
}