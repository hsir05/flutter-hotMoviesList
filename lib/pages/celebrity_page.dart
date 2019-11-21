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
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: celebrityEntity.photos.length,
            itemBuilder: (BuildContext context, int index) {
              return celebrityEntity.photos[index].image == null? Image.asset("images/ic_default_img_subject_movie.8.png",width: 50.0) : Image.network(celebrityEntity.photos[index].image, height: ScreenUtil.getInstance().getAdapterSize(130),  fit: BoxFit.contain);
            },
          ),
        
        // Row(children: <Widget>[
        //   Container(
        //     height: ScreenUtil.getInstance().getAdapterSize(280),
        //     child: celebrityEntity.avatars == null ? Image.asset("images/ic_default_img_subject_movie.8.png",width: 50.0) : Image.network(celebrityEntity.avatars.medium),
        //   ),

        // ]),
      );
    }


}