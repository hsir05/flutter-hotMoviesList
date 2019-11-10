import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/res/resources.dart';
import 'package:movies/constant/constant.dart';
import 'package:movies/widget/radius_img.dart';
import 'package:movies/widget/loading_widget.dart';
// import 'package:movies/widget/video_widget.dart';

import './searchBar.dart';
import '../service/service_method.dart';
import '../model/hot_model.dart';

 final List<Tab> myTabs = <Tab>[
    Tab(text: '正在热映'),
    Tab(text: '即将上映'),
  ];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {

  List<Subject> list = [];

  TabController _tabController;
  int _currentIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(() => _onTabChanged());

    Future(() {
      return request('hotPageContext', null);
    }).then((result) {
      var resultList = result['subjects'];
      setState(() {
        list =resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        loading = false;
      });
    });
  }

  _onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation.value) {
      //赋值 并更新数据
      this.setState(() {
        _currentIndex = _tabController.index;
      });
      // _getData();
    }
  }

  void _getData(){
    request('hotPageContext', null).then((result){
        var resultList = result['subjects'];
        list = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        print('+++++++++++++');
        print(list);
        setState(() {});
    }); 
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          margin: EdgeInsets.only(left: 4.0),
          alignment: Alignment.center,
          child: Row(children: <Widget>[
            Text('兰州', style: TextStyle(fontWeight: FontWeight.w700, color: Colours.text)),
            Icon(Icons.arrow_drop_down, color: Colours.text,)
          ],),
        ),
        title: InkWell(
          onTap: (){
             showSearch(context: context,delegate: SearchBarDelegate());
          },
          child: Container(
          height: 40.0, 
          padding: EdgeInsets.only(left: 5.0),
          decoration: BoxDecoration(
            color: Colours.bg_color,
            borderRadius: BorderRadius.all(new Radius.circular(5.0)),
            border: Border.all(width: 1.0, color: Colors.white)
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.search, color: Colors.black26,),
              Text('电影/电视剧/影人', style: TextStyle(fontSize: 14.0, color: Colors.black26),)
            ],
          ),
        ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
          onTap: (int i){
            print(i);
          },
          labelColor: Colours.text,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
         return handelTabs();
        }).toList(),
      )
    );
  }

  Widget handelTabs() {
    if (_currentIndex == 1) {
      return Text('即将上映');
    } else {
         return LoadingWidget.containerLoadingBody(_getBody(), loading: loading);
    }
  }

  Widget _getBody() {
    if (list == null) {
      return Container(
        child: Image.asset(Constant.ASSETS_IMG + 'ic_group_top.png'),
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Subject bean = list[index ];
        return Padding(
          padding: const EdgeInsets.only(right: Constant.MARGIN_RIGHT, left: 6.0, top: 13.0),
          child: _getItem(bean, index ),
          // child: getItem(bean ),
        );
      },
      itemCount: list.length ,
    );
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

  Widget _getItem(Subject bean, int index) {
    var avatars = List.generate(bean.casts.length, (int index) =>
        Container(
          margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 16.0),
          child: 
          CircleAvatar(
              backgroundColor: Colors.white10,
              backgroundImage: 
              bean.casts[index].avatars == null ?  AssetImage("assets/images/avatar.png") : NetworkImage( 
                bean.casts[index].avatars.small 
              )
          ),
        ),
    );
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: 
      Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              bean.images.large, 
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
                      bean.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      '豆瓣评分：${bean.rating.average}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text( "类型：${bean.genres.join("、")}" ),
                    Text( '导演：${bean.directors[0]['name']}' ),
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
    ),
      onTap: () {
        print(444);
        // Router.push(context, Router.detailPage, bean.id);
      },
    );
  }
}
