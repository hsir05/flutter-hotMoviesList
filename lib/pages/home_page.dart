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
  // final List<Tab> myTabs = <Tab>[
  //   Tab(text: '正在热映'),
  //   Tab(text: '即将上映'),
  // ];

  List<Subject> list = [];

  TabController _tabController;
  int _currentIndex = 0; //选中下标
  bool loading = true;

  @override
  void initState() {
    super.initState();
    // _getData();
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
         return LoadingWidget.containerLoadingBody(_getBody(), loading: loading);
        }).toList(),
      )
    );
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
        );
      },
      itemCount: list.length ,
    );
  }

  Widget _getItem(Subject bean, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: <Widget>[
          RadiusImg.get(bean.images.small, 50.0, radius: 3.0),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(bean.title,style:TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                  Text(bean.pubdates != null ? bean.pubdates[0] : '', style: TextStyle(fontSize: 13.0))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Text('${bean.collect_count}人', style: TextStyle(fontSize: 13.0),),
          ),
          GestureDetector(
            child: Image.asset(
              Constant.ASSETS_IMG +
                  (list[index].tag
                      ? 'ic_group_checked_anonymous.png'
                      : 'ic_group_check_anonymous.png'),
              width: 25.0,
              height: 25.0,
            ),
            onTap: () {
              setState(() {
                list[index].tag = !list[index].tag;
              });
            },
          )
        ],
      ),
      onTap: () {
        // Router.push(context, Router.detailPage, bean.id);
      },
    );
  }

  Widget _noData() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/noInfo.png', width: 130.0,),
            Text('暂无数据呢...')
          ],
        )
        );
  }
}
