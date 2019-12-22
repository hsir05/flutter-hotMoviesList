import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flustars/flustars.dart';
import 'package:douban/widget/video_widget.dart';
import 'package:douban/res/resources.dart';
import '../model/movie_detail_bean.dart';
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
        print(widget.id);
    _getData({'apikey': '0b2bdeda43b5688921839c8ecb20399b'});
  }

  void _getData(data){
    request('movieDetailContext?${widget.id}', data).then((result){
        setState(() {
          movDetail = MovieDetailBean.fromJson(result);
         print('================');
          if (movDetail.bloopers.length != 0){
            vidoeUrl = movDetail.bloopers[0].resource_url;
          } else if (movDetail.trailers.length != 0){
            vidoeUrl = movDetail.trailers[0].resource_url;
          }
          loading = false;
          videoLoading = false;
        });
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: GestureDetector(
        onHorizontalDragEnd: (details){
          Navigator.pop(context);
        },
        child: Scaffold(
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
    )
    ) );
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
      width: ScreenUtil.getInstance().screenWidth,
      height: ScreenUtil.getInstance().getAdapterSize(180),
      child: videoLoading ? CupertinoActivityIndicator() :VideoWidget( vidoeUrl, showProgressBar: false ),
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
              padding: EdgeInsets.only(top: 15.0, left: 15.0, bottom: 20.0),
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
      padding: EdgeInsets.only(left:10.0, bottom: 10.0),
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
