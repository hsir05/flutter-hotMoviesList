import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/res/resources.dart';
import 'package:flustars/flustars.dart';
// import 'package:fluro/fluro.dart';
import '../service/service_method.dart';
import '../model/celebrity_entity.dart';

class CeleBrityPage extends StatefulWidget {
  final String id;
  CeleBrityPage({Key key,@required this.id}):super(key:key);
  @override
  _CeleBrityPageState createState() => _CeleBrityPageState();
}

class _CeleBrityPageState extends State<CeleBrityPage> {
  bool loading = true;
 CelebrityEntity celebrityEntity;

@override
  void initState () {
    super.initState();
    print('电影id:-->' + widget.id);
    _getData({'apikey': '0b2bdeda43b5688921839c8ecb20399b'});
  }

  void _getData(data){
    request('celebrityContext?${widget.id}', data).then((result){
        setState(() {
          celebrityEntity = CelebrityEntity.fromJson(result);
          print(celebrityEntity.avatars);

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
            child: ListView(
              children: <Widget>[
                
                _celePhot(),

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
                    margin: EdgeInsets.only(right: 20.0),
                    color: Colors.redAccent,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.filter_list),
                            Text('收藏')
                          ],
                        ),
                        // Text(celebrityEntity.collect_count)
                      ],
                    ),
                  )
                ],
              ),

              Gaps.vGap10,
              Text('个人简介', style: TextStyles.textDarkGray14),
              Gaps.vGap5,
              ListTile(
                onTap: (){
                  print('1312313');
                },
                title: Text(celebrityEntity.summary, style: TextStyles.textBold12, maxLines: 2, overflow: TextOverflow.ellipsis,),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),

              Text('代表作品', style: TextStyles.textDarkGray14),

              ],
            ),
          );
      }
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
              child: celebrityEntity.avatars == null ? Image.asset("images/ic_default_img_subject_movie.8.png",width: 50.0) : Image.network(celebrityEntity.avatars.medium),
            ),
          ],
        )
      );
    }


}