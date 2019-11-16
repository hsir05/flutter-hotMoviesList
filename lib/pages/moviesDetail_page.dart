import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/res/resources.dart';
import 'package:flustars/flustars.dart';
import '../service/service_method.dart';
import '../model/movie_detail_bean.dart';

class MoviesDetailPage extends StatefulWidget {
  final String id;
  MoviesDetailPage({Key key,@required this.id}):super(key:key);

  @override
  _MoviesDetailPageState createState() {
    return _MoviesDetailPageState();
  }
}

class _MoviesDetailPageState extends State<MoviesDetailPage> {
 
  MovieDetailBean movDetail;
  bool loading = true;

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
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Colours.bg_detail_color,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
                Navigator.pop(context);
            }),
        title: loading ? CupertinoActivityIndicator() : Text(movDetail.title, style: TextStyle(color: Colors.white),), 
        centerTitle: true),
      body: _getBody(context)
      );
  }

  Widget _getBody(BuildContext context) {
    if (loading) {
      return Text('');
      // return Container(child: Center(child: CupertinoActivityIndicator()));
    } else {
      return Container(
        child: ListView(
          children: <Widget>[

            Container(
              width: ScreenUtil.getInstance().screenWidth, 
              height: ScreenUtil.getInstance().getAdapterSize(300),
              padding: EdgeInsets.only(top: 25.0, bottom:  25.0),
              alignment: Alignment.center,
              color: Colours.bg_detail_color,
              child: movDetail == null ? Image.asset("images/ic_default_img_subject_movie.8.png", width: 50.0,) : Image.network(movDetail.images.small),
            ),

            Gaps.vGap16,
            
            Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().getAdapterSize(300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(movDetail.title, style: TextStyles.textBold20),
                    
                      Row(
                        children: <Widget>[
                          Text(movDetail.year, style: TextStyles.textSize12,),
                          Text(movDetail.countries[0], style: TextStyles.textSize12,),
  // genres
                        ],
                      ),
                      Text('原名：${movDetail.original_title}', style: TextStyles.textSize12),
                      Text('上映时间：${movDetail.pubdates[1]}', style: TextStyles.textSize12),
                    ],
                  ),
                ),

              ],
            ),

          ],
        ),
      );
    }
  }

  Widget _tag() {

  }

}

class ContentArea extends StatelessWidget {
  var content;
  var movDetail = {};
  ContentArea({Key key, @required this.content, @required this.movDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var castList = List.generate(content['casts'].length, (int index) =>
        Container(
          margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 8.0),
          child: Center(
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(content['casts'][index]['avatars']['small'],height: 150.0,),
                ),
                Text(content['casts'][index]['name'])
              ],
            ),
          )
        ),
    );
    
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
            children: <Widget>[
              Container(
                width: 130.0,
                margin: EdgeInsets.only(right: 10.0),
                child:ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(content['images']['small'], fit: BoxFit.contain,),
              )
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(content['title'], style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                    Text( '导演：${content['directors'][0]['name']}' ),
                    Text( "类型：${content['genres'].join("、")}" ),
                    // Text( "上映时间：${movDetail['attrs']['pubdate']}" ),
                    // Text("${movDetail['attrs']['movie_duration']} ${movDetail['attrs']['language']}"),
                    Text('${content['collect_count']} 人想看'),
                    Text('豆瓣评分 ${content['rating']['average']}'),
                  ],
                ),
              )
            ],
          ),),
          // 标签
          Container(
            padding: EdgeInsets.all(10.0),
            width: 100.0,
            child: Text('标签',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),),
          ),
          
          Divider(),
        
          // _getTags(),

          // 电影介绍
          Padding(
            padding: EdgeInsets.only(top:15.0,left: 10.0,right: 10.0),
            child: Text('介绍',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700)),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('${movDetail['summary']}',style: TextStyle(fontSize: 16.0,)),
          ),
          // 演职人员
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0),
            child: Text('主演',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          ),
          Divider(),
          
          Container(
            height:200.0,
            margin: EdgeInsets.only(left:10.0,top: 10.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: castList,
            )
          ),
          Divider(),
        ],
      ),
    );
  }

  
    Widget _getTags() {
      print('++++++++++++++');
      print(movDetail['tags']);
      if (movDetail['tags'] != null && movDetail['tags'].length != 0 ) {
        List<Widget>listWidget = movDetail['tags'].map((val){
          return Container(
              padding: EdgeInsets.all(5.0),
              height: 30.0,
              width: 100.0,
              alignment: Alignment.bottomLeft,
              child: Text(val, style: TextStyle(fontSize: 16.0), textAlign:TextAlign.center)
            );
            }).toList();
          return Wrap(
            spacing: 2,
            children: listWidget,
          );
      } else {
        return Center( child: CupertinoActivityIndicator());
      }
  }
}
