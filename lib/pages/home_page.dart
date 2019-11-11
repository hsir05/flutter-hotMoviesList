import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flustars/flustars.dart';
import 'package:movies/res/resources.dart';
import 'package:movies/constant/constant.dart';
// import 'package:movies/widget/radius_img.dart';
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
  List<Subject> hotList = [];
  List<Subject> comingSoonList = [];
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
        list = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        hotList = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        loading = false;
      });
    });
  }

  _onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation.value) {
      //赋值 并更新数据
      this.setState(() {
         list = [];
        loading = true;
        _currentIndex = _tabController.index;
        
        String url;
        if(_currentIndex == 0) {
          url = 'hotPageContext';
        } else {
          url = 'upComContext';
        }
        _getData(url);
      });
    }
  }

  void _getData(url){
    request(url, null).then((result){
        var resultList = result['subjects'];
         List<Subject> data = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        print('+++++++++++++');
        setState(() {
          loading = false;
            if (_currentIndex == 0) {
              hotList = data;
            } else {
              comingSoonList = data;
            }
            list = data;
          });
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
          margin: EdgeInsets.only(left: 11.0),
          alignment: Alignment.center,
          child: Row(children: <Widget>[
            Text('兰州', style: TextStyle(fontWeight: FontWeight.w700, color: Colours.text)),
            Icon(Icons.arrow_drop_down, color: Colours.text, size: ScreenUtil.getInstance().getAdapterSize(14),)
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
            setState(() {
              list = [];
            });
          },
          labelColor: Colours.text,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
        //  return handelTabs();
        return LoadingWidget.containerLoadingBody(_getBody(list), loading: loading);
        }).toList(),
      )
    );
  }

  Widget handelTabs() {
    if (_currentIndex == 1) {
      return LoadingWidget.containerLoadingBody(_getBody(comingSoonList), loading: loading);
    } else {
      return LoadingWidget.containerLoadingBody(_getBody(hotList), loading: loading);
    }
    // return LoadingWidget.containerLoadingBody(_getBody(list), loading: loading);
  }

  Widget _getBody(list) {
    if (list == null) {
      return Container(
        child: Image.asset(Constant.ASSETS_IMG + 'ic_group_top.png'),
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Subject bean = list[index];
        return Padding(
          padding: const EdgeInsets.only(right: Constant.MARGIN_RIGHT, left: 6.0, top: 13.0),
          child: _getItem(bean, index),
        );
      },
      itemCount: list.length ,
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
              bean.casts[index].avatars == null ?  AssetImage("images/avatar.png") : NetworkImage( 
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
              width: ScreenUtil.getInstance().getAdapterSize(90), 
              height: ScreenUtil.getInstance().getAdapterSize(130),
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
               child: Container(
                margin: EdgeInsets.only(left: 8.0),
                height: ScreenUtil.getInstance().getAdapterSize(130),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 电影名称
                    Text(
                      bean.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil.getInstance().getAdapterSize(16)
                      ),
                      maxLines: 1,
                    ),
                    Gaps.vGap5,
                    Row(
                      children: <Widget>[
                        Expanded(child: Text( '豆瓣评分：${bean.rating.average}', style: TextStyle(fontSize: 12.0, color: Colours.text_star)),),
                        Text('有${bean.collect_count}人${_currentIndex == 0 ? "看过" : "想看"}', style: TextStyle(fontSize: 12.0, color: Colours.text_star))
                      ],
                    ),
                    Gaps.vGap5,
                    Text( "类型：${bean.genres.join("、")}" ),
                    Gaps.vGap5,
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
