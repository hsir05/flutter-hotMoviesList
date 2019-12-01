import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/res/resources.dart';
import 'package:flustars/flustars.dart';
import 'package:fluro/fluro.dart';
import '../service/service_method.dart';
import '../model/celebrity_entity.dart';
import '../model/celebrity_work_entity.dart';
import '../utils/util.dart';
import '../routers/application.dart';
import '../widget/photoViewSimpleScreen.dart';

class CeleBrityPage extends StatefulWidget {
  final String id;
  CeleBrityPage({Key key,@required this.id}):super(key:key);
  @override
  _CeleBrityPageState createState() => _CeleBrityPageState();
}

class _CeleBrityPageState extends State<CeleBrityPage> {
  bool loading = true;
 CelebrityEntity celebrityEntity;
 CelebrityWorkEntity celebrityWorkEntity;

@override
  void initState () {
    super.initState();
    print('电影id:-->' + widget.id);
    _getData({'apikey': '0b2bdeda43b5688921839c8ecb20399b'});
  }

  void _getData(data) async{
    var result = await request('celebrityContext?${widget.id}', data); 
    var res = await request('celebrityWidgetContext?${widget.id}/works', data);
    setState(() {
      celebrityEntity = CelebrityEntity.fromJson(result);
      celebrityWorkEntity = CelebrityWorkEntity.fromJson(res);
      loading = false;
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
              actions: <Widget>[
               IconButton(
                icon: Image.asset('images/share.png', width: 20.0,),
                tooltip: '分享',
                onPressed: () {
                  Util.showShareModalBottom(context);
                }),
            ],
        title: loading ? CupertinoActivityIndicator() : Text('影人', style: TextStyle(color: Colors.white),), 
        centerTitle: true),
      body: _getBody(context)
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
                
                _celePhot(),

                Container(
                  padding: EdgeInsets.only(left:20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Gaps.vGap10,
              
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(celebrityEntity.name, style: TextStyles.textBold16),
                                Gaps.vGap5,
                                Text(celebrityEntity.name_en, style: TextStyles.textDarkGray12),
                              ],
                            ),
                          ),

                          Container(
                            width: ScreenUtil.getInstance().getAdapterSize(60),
                            height:ScreenUtil.getInstance().getAdapterSize(40),
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.add),
                                    Text('收藏')
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                      Gaps.vGap15,
                      Text('个人简介', style: TextStyles.textDarkGray14),
                      
                      Gaps.vGap10,
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                _dialog(context);
                              },
                              child: Text(celebrityEntity.summary.isEmpty ? '暂无' : celebrityEntity.summary, style: TextStyles.textSize12, maxLines: 2, overflow: TextOverflow.ellipsis,)
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 18.0, color: Colours.bg_detail_color,)
                        ],
                      ),
                      
                      Gaps.vGap15,
                      Text('代表作品', style: TextStyles.textDarkGray14),
                      Gaps.vGap10,
                      _getRepresentative(celebrityEntity.works),

                      Gaps.vGap15,
                      Text('全部作品', style: TextStyles.textDarkGray14),
                      Gaps.vGap10,
                      _getRepresentative(celebrityWorkEntity.works),

                    ],
                  ),
                )
              ],
            ),
          );
      }
    }

    _dialog(context) {
       showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                brightness: Brightness.dark,
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                    icon: Icon(Icons.close, color: Colours.bg_detail_color,),
                    onPressed: () {
                        Navigator.pop(context);
                    }),
                title: Text('影人资料'), 
                centerTitle: true),
                body: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: ListView(
                    children: <Widget>[
                      Text(celebrityEntity.name, style: TextStyles.textBold20,),
                      Text(celebrityEntity.name_en, style: TextStyles.textBold12,),
                      Gaps.vGap15,

                       _info(Icons.person_pin, '性别:', celebrityEntity.gender),
                      Gaps.vGap8,
                       _info(Icons.blur_on, '星座:', celebrityEntity.constellation),
                      Gaps.vGap8,
                       _info(Icons.calendar_today, '出生日期:', celebrityEntity.birthday),
                      Gaps.vGap8,
                       _info(Icons.room, '出生地:', celebrityEntity.born_place),
                      Gaps.vGap8, 
                       _info(Icons.face, '更多中文名:', Util.strSplic(celebrityEntity.aka)),

                      Gaps.vGap15,
                      Text(celebrityEntity.summary, style: TextStyles.textBold12, softWrap: true)

                    ],
                  ),
                ),
            );
          }
      );
    }

    Widget _info(icon, infoKey, infoVal){
      return Row(
        children: <Widget>[
          SizedBox(
          width: ScreenUtil.getInstance().getAdapterSize(100),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 16, color: Colours.bg_detail_color,),
              Gaps.hGap5,
              Text(infoKey, style: TextStyles.textBold12),
            ],
          ),
        ),
        Text(infoVal, style: TextStyles.textBold12)
        ],
      );
    }

    Widget _celePhot() {
      return Container(
        padding: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 15.0),
        color: Colours.bg_detail_color,
        height: ScreenUtil.getInstance().getAdapterSize(280),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              height: ScreenUtil.getInstance().getAdapterSize(280),
              child: celebrityEntity.avatars == null ? Image.asset("images/ic_default_img_subject_movie.8.png",width: 50.0) : InkWell(
                onTap: (){
                  _photoView(context);
                },
                child: Image.network(celebrityEntity.avatars.medium),
              ),
            ),
          ],
        )
      );
    }

  void _photoView(context) {
    showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
            return PhotoViewSimpleScreen(
                imageProvider:NetworkImage(celebrityEntity.avatars.large),
                heroTag: 'simple',
              );
        },
    );
}

    Widget _getRepresentative(list) {
        var castList = List.generate(list.length, (int index) =>
            InkWell(
              onTap: (){
                Application.router.navigateTo(context,"/movieDetail?id=${list[index].subject.id}", transition: TransitionType.inFromRight);
              },
              child: Container(
                width: ScreenUtil.getInstance().getAdapterSize(100),
                margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect( 
                      borderRadius: BorderRadius.circular(6.0),
                      child: list[index].subject == null ? Container(height: ScreenUtil.getInstance().getAdapterSize(130), padding: EdgeInsets.all(40.0),child: Image.asset("images/ic_default_img_subject_movie.8.png"),) : Image.network(list[index].subject.images.large,height: ScreenUtil.getInstance().getAdapterSize(130),)
                    ),
                    Gaps.vGap10,
                    Text(list[index].subject.title, style: TextStyles.textBold14, overflow: TextOverflow.ellipsis,),
                    Text('豆瓣评分${list[index].subject.rating.average}', style: TextStyles.textGray12,)
                  ],
                )
              ),
            )
        );
        return Container(
          height:200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: castList,
          )
        );
    }
}

