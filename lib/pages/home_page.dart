import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/res/resources.dart';
import './searchBar.dart';
import '../service/service_method.dart';
import '../model/hot_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '正在热映'),
    Tab(text: '即将上映'),
  ];

  List<Subject> list = [];

  TabController _tabController;
  // int _currentIndex = 0; //选中下标

  @override
  void initState() {
    super.initState();
    // _getData();
    _tabController = TabController(vsync: this, length: myTabs.length);
    // _tabController.addListener(() => _onTabChanged());
  }

     /// tab改变监听
  // _onTabChanged() {
  //   if (_tabController.index.toDouble() == _tabController.animation.value) {
  //     //赋值 并更新数据
  //     // this.setState(() {
  //     //   _currentIndex = _tabController.index;
  //     // });
  //     // _getData();
  //   }
  // }

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
        backgroundColor: Colours.bg_color,
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
            border: Border.all(width: 1.0, color: Colours.text_gray)
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
        // children: _wrapList(context, list)
        children: myTabs.map((Tab tab) {
          return Center(child: Text(tab.text));
        }).toList(),
      )
    );
  }

   _wrapList(context, list) {
    if (list.length!= 0){
      List<Widget>listWidget = list.map((val){
          return getItem(val);
      }).toList();
       return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }
  }

  getItem(var subject) {
    //    演员列表
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
       print('3333');
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

