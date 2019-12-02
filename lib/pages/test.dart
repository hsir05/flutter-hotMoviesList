import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../service/service_method.dart';
import '../model/movie_detail_bean.dart';
import '../model/photo_model_entity.dart';
import '../utils/util.dart';

class TestPage extends StatefulWidget {
  final String id;
  TestPage({Key key,@required this.id}):super(key:key);

  @override
  _TestPageState createState() {
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage> {
  
  MovieDetailBean movDetail;
  bool loading = true;
  bool isOpen = false;
 PhotoModel photSub;

  @override
  void initState () {
    super.initState();
    _getData({'apikey': '0b2bdeda43b5688921839c8ecb20399b'});
  }

  void _getData(data){
    request('movieDetailContext?${widget.id}', data).then((result){
        setState(() {
          movDetail = MovieDetailBean.fromJson(result);
          loading = false;
        });
    }); 
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.dark,
        elevation: 0,
         backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
                Navigator.pop(context);
            }),
            actions: <Widget>[
               IconButton(
                icon: Image.asset('images/share.png', width: 20.0,),
                tooltip: '分享',
                onPressed: () {
                  Util.showShareModalBottom(context);
                }),
            ],
        title: loading ? CupertinoActivityIndicator() : Text(movDetail.title, style: TextStyle(color: Colors.white),), 
        centerTitle: true),
      body: Container(
        child: Center(
          child: Text('test'),
        ),
      )
      );
  }

}
