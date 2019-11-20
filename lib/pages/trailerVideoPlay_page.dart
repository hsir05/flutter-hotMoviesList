import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flustars/flustars.dart';
import 'package:movies/widget/video_widget.dart';
import 'package:movies/res/resources.dart';
import '../model/movie_detail_bean.dart';
import 'package:movies/widget/loading_widget.dart';
import 'dart:async';
import '../service/service_method.dart';


class TrailerViderPlayPage extends StatefulWidget {
    final String id;
  TrailerViderPlayPage({Key key,@required this.id}):super(key:key);

  @override
  _TrailerViderPlayPageState createState() => _TrailerViderPlayPageState();
}

class _TrailerViderPlayPageState extends State<TrailerViderPlayPage> {

  MovieDetailBean movDetail;
  bool loading = true;
  bool videoLoading = true;
  String vidoeUrl;
  Timer timer;

  @override
  void initState () {
    super.initState();
    _getData({'apikey': '0b2bdeda43b5688921839c8ecb20399b'});
  }

  void _getData(data){
    request('movieDetailContext?${widget.id}', data).then((result){
        setState(() {
          movDetail = MovieDetailBean.fromJson(result);
          vidoeUrl = movDetail.bloopers[0].resource_url;
          loading = false;
          videoLoading = false;
        });
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Colours.bg_detail_color,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            }), 
        centerTitle: true,
        title: loading ? Text('') : Text(movDetail.title),
        ),
        body: _getBody(),
    );
  }

  Widget _getBody() {
    if (loading) {
      return Container(child: Center(child: CupertinoActivityIndicator()));
    } else {
      return Column(
        children: <Widget>[

          _getContentVideo(),

          _blooper()
        ],
      );
    }
  }

  Widget _getContentVideo() {
    return Container(
      margin: EdgeInsets.only(top: 1.0),
      width: ScreenUtil.getInstance().screenWidth,
      height: ScreenUtil.getInstance().getAdapterSize(180),
      child: videoLoading ? CupertinoActivityIndicator() :VideoWidget( vidoeUrl, showProgressBar: true ),
    );
  } 

  Widget _blooper() {

     return Container(
        height: (ScreenUtil.getInstance().screenHeight - 180.0 - 105.0),
        padding: EdgeInsets.only(top: 12.0, left: 12.0),
        child:ListView(
          children: <Widget>[
            Divider(),
            ListTile(
            onTap: (){
              Navigator.pop(context);
            },
            title:Text( movDetail.title, style: TextStyles.textSize16, textAlign: TextAlign.left,),
            trailing: Icon(Icons.keyboard_arrow_right),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.star, size: 16.0, color: Colours.text_star),
                Icon(Icons.star, size: 16.0, color: Colours.text_star),
                Icon(Icons.star, size: 16.0, color: Colours.text_star),
                Icon(Icons.star, size: 16.0, color: Colours.text_star),
                Icon(Icons.star_border, size: 16.0, color: Colours.text_star),
              ],
            ),
          ),
            Divider(),

            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 15.0),
              child: Text('观看预告片 / 花絮 / 片段', style: TextStyles.textDarkGray14),
            ),

            _contentList(movDetail.bloopers),
            _contentList(movDetail.trailers),

          ],
        )
         );
  }

  Widget _contentList(list) {
    if (list.length!= 0){
 
      var listWidget = List.generate(list.length, (int index) => _getItem(list[index]));

      return Wrap(
          spacing: 2,
          children: listWidget,
        );
    } else {
      return Text('');
    }
  }

  void countdown(){
    timer = new Timer(new Duration(seconds: 1), () {
        print('9999999');
        setState(() {
          videoLoading = false;
        });
    });
  }
  Widget _getItem(item) {
    return InkWell(
      onTap: (){
        setState(() {
          videoLoading = true;
          vidoeUrl = item.resource_url;
          countdown();
        });
      },
      child: Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(
                item.medium, 
                height: ScreenUtil.getInstance().getAdapterSize(80), 
                width: ScreenUtil.getInstance().getAdapterSize(120),
                fit: BoxFit.fill,
              ),
            ),
            Gaps.hGap5,
            Expanded(
              child: vidoeUrl == item.resource_url ? Text(item.title, softWrap: true, style: TextStyle(color: Colours.text_star),) : Text(item.title, softWrap: true) 
            )
        ],
      ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }
}
