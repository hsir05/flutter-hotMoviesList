import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:douban/res/resources.dart';
import 'package:flustars/flustars.dart';
import 'package:fluro/fluro.dart';
import '../service/service_method.dart';
import '../model/movie_detail_bean.dart';
import '../model/photo_model_entity.dart';
import '../routers/application.dart';
import '../utils/util.dart';

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
  bool isOpen = false;
 PhotoModel photSub;

  @override
  void initState () {
    super.initState();
    print('电影id:-->' + widget.id);
    _getData({'apikey': '0b2bdeda43b5688921839c8ecb20399b'});
    // _getPhotoData({'apikey': '0b2bdeda43b5688921839c8ecb20399b'});
  }

  void _getData(data){
    request('movieDetailContext?${widget.id}', data).then((result){
        setState(() {
          movDetail = MovieDetailBean.fromJson(result);
          loading = false;
        });
    }); 
  } 
  // 电影条目剧照
  // void _getPhotoData(data){ 
  //   request('movieDetailContext?${widget.id}/photos', data).then((result){
  //       setState(() {
  //         // var photoList = result['photos'];
  //         loading = false;
  //       });
  //   }); 
  // }

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
            //  backgroundColor: Colors.transparent,
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
          body: _getBody(context)
          ),
      )
    );
  }

  

  Widget _getBody(BuildContext context) {
    if (loading) {
      return Container(child: Center(child: Image.asset("images/ic_default_img_subject_movie.8.png",width: 50.0),));
    } else {
      return Container(
        color: Colours.bg_color,
        child: ListView(
          children: <Widget>[

            Container(
              width: ScreenUtil.getInstance().screenWidth, 
              height: ScreenUtil.getInstance().getAdapterSize(300),
              padding: EdgeInsets.only(top: 25.0, bottom:  25.0),
              alignment: Alignment.center,
              color: Colours.bg_detail_color,
              child: loading ? Image.asset("images/ic_default_img_subject_movie.8.png", width: 50.0,) : Image.network(movDetail.images.small),
            ),

            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Text(movDetail.title, style: TextStyles.textBold24),
                              _type(),
                              Text('原名：${movDetail.original_title}', style: TextStyles.textDarkGray12),
                              Text('上映时间：${movDetail.pubdate}', style: TextStyles.textDarkGray12),
                              _duration()

                            ],
                          ),
                        ),
                      ),
                      
                      Container(
                          width: ScreenUtil.getInstance().getAdapterSize(80),
                          height: ScreenUtil.getInstance().getAdapterSize(90),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Color(0xFFe8e9ee), offset: Offset(5.0, 5.0),    blurRadius: 10.0, spreadRadius: 2.0), BoxShadow(color: Color(0xFFe8e9ee), offset: Offset(1.0, 1.0)), BoxShadow(color: Color(0xFFe8e9ee))],
                          ),
                          child: Column(
                            children: <Widget>[
                              Gaps.vGap10,
                              Text('豆瓣评分', style: TextStyles.textDarkGray12, textAlign: TextAlign.center),
                              Gaps.vGap5,
                              Text('${movDetail.rating.average}', style: TextStyles.textBold24, textAlign: TextAlign.center,),
                              Gaps.vGap5,
                              Text('${movDetail.ratings_count}人', style: TextStyles.textDarkGray12,)
                            ]),
                        ),
                    
                    ],
                  ),

                  Gaps.vGap16,
                  
                  Row(
                    children: <Widget>[

                       OutlineButton(
                        onPressed: () {},
                        textColor: Colours.text,
                        color: Colours.bg_color,
                        borderSide: BorderSide(color: Colours.btn_border_color),
                        padding: EdgeInsets.only(top: 10.0, bottom:  10.0, right: 45.0, left: 45.0),
                        child: Text("想看", style: TextStyle(color: Colours.btn_border_color,),
                      ),
                      ),

                      Gaps.hGap15,

                      Expanded(
                        child:OutlineButton(
                          onPressed: () {},
                          textColor: Colours.text,
                          color: Colours.bg_color,
                          borderSide: BorderSide(color: Colours.btn_border_color),
                          padding: EdgeInsets.only(top: 10.0, bottom:  10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("看过", style: TextStyle(color: Colours.btn_border_color)),
                              Icon(Icons.star_border, color: Colours.text_star, size: 18.0),
                              Icon(Icons.star_border, color: Colours.text_star, size: 18.0),
                              Icon(Icons.star_border, color: Colours.text_star, size: 18.0),
                              Icon(Icons.star_border, color: Colours.text_star, size: 18.0),
                              Icon(Icons.star_border, color: Colours.text_star, size: 18.0),
                            ],
                          )
                        )
                      )

                    ],
                  ),

                  Gaps.vGap16,

                  Text('剧情简介', style: TextStyles.textDarkGray12),

                  Gaps.vGap8,

                  Stack( 
                    children: <Widget>[
                      
                      Text(movDetail.summary, style: TextStyles.textSize14, softWrap:isOpen),

                      isOpen ? Text('') : Positioned(
                        right: 0,
                        bottom: 1.0,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              isOpen  = !isOpen;
                            });
                          },
                          child: Container(
                            width: 41.0,
                             decoration: BoxDecoration(
                               color: Colours.bg_color
                                // gradient: LinearGradient(
                                //   begin: Alignment.centerLeft,
                                //   end: Alignment.centerRight,
                                //   colors: [
                                //     Color.fromRGBO(255,255,255,1),
                                //     Color.fromRGBO(255,255,255,1),
                                //   ],
                                // ),
                              ),
                            child: Text('...展开', style: TextStyles.textGreen14, overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                          ),
                        ),
                      )
                    ],
                  ),

                  Gaps.vGap16,

                  Text('影人', style: TextStyles.textDarkGray12),

                  Gaps.vGap16,

                  _casts(movDetail.casts),
                  
                  Gaps.vGap8,
                  Text('预告片 / 剧照', style: TextStyles.textDarkGray12),
                  Gaps.vGap16,
                  _trailerUrl(),
                  
                  Gaps.vGap16,

                ],
              )
            )],
        ),
      );
    }
  }
 
  Widget _duration() {
    return Text('片长：' + Util.strSplic(movDetail.durations), style: TextStyles.textDarkGray12, softWrap: true);
  }

  Widget _type() { 
    return Text(movDetail.year + ' ' + Util.strSplic(movDetail.genres) + ' / ' +  Util.strSplic(movDetail.countries), style: TextStyles.textDarkGray12, softWrap: true);
  }

  Widget _casts(list) {
    if (list.length == 0) {
      return Text('');
    }
    var castList = List.generate(list.length, (int index) =>
        InkWell(
          onTap: (){
            Application.router.navigateTo(context,"/celeBrity?id=${list[index].id}", transition: TransitionType.inFromRight);
          },
          child: Container(
          margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect( 
                borderRadius: BorderRadius.circular(6.0),
                child: list[index].avatars == null ? Container(height: 150.0, padding: EdgeInsets.all(40.0),child: Image.asset("images/ic_default_img_subject_movie.8.png"),) : Image.network(list[index].avatars.small,height: 150.0,)
              ),
              Gaps.vGap5,
              Text(list[index].name, style: TextStyles.textSize14)
            ],
          )
        ),
        )
    );
    return Container(
      height:180.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: castList,
      )
    );
  }


  Widget _trailerUrl() {
     if (movDetail.photos == null || movDetail.photos.length == 0) {
      return Text('');
    }
    var castList = List.generate(movDetail.photos.length, (int index) =>
        InkWell(
          onTap: (){print(movDetail.photos[index]);},
          child: Container( 
            margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 8.0),
            child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(movDetail.photos[index].image, height: ScreenUtil.getInstance().getAdapterSize(150),),
                ),
          ),
        )
    );

    var photoCount = InkWell(
      onTap: (){print('全部');},
        child: Container(
          height: ScreenUtil.getInstance().getAdapterSize(150),
          width: ScreenUtil.getInstance().getAdapterSize(150),
          color: Colours.bg_gray,
          child: Center(child: InkWell(
            onTap: (){print('132');},
            child: Text('全部剧照${movDetail.photos_count}', style: TextStyles.textSize14),
          )),
        ),
    );

    
    var videoTra = InkWell(
      onTap: (){ 
        if (movDetail.bloopers.length != 0 && movDetail.trailers.length != 0) {
          Application.router.navigateTo(context,"/trailerVideo?id=${widget.id}", transition: TransitionType.inFromRight);
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 20.0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: movDetail.trailers.length == 0 ? Container(
                width: 130.0,
                child: Center(child: Image.asset("images/ic_default_img_subject_movie.8.png", width: 50.0,),),
              ) : Image.network(movDetail.trailers[0].medium),
            ),
            Positioned(
              top: ScreenUtil.getInstance().getAdapterSize(75),
              left: ScreenUtil.getInstance().getAdapterSize(125),
              child: Image.asset('images/ic_playing.png', height: ScreenUtil.getInstance().getAdapterSize(30),),
            )
          ],
        ),
      ),
    );

    castList.add(photoCount);
    if(movDetail.bloopers.length != 0 || movDetail.trailers.length != 0) {
      castList.insert(0, videoTra);
    }

    return Container(
      height: ScreenUtil.getInstance().getAdapterSize(160),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: castList,
      )
    );
  }

  Widget _tag(list) {
    List<Widget>listWidget = list.map((item){
        return Text(item, style: TextStyles.textSize12);
      }).toList();
    return Container(
      child: Wrap(
        spacing: 2,
        children: listWidget,
      ),
    );
  }

}
