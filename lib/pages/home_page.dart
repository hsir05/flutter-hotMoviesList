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

  List<Subject> list;

  TabController _tabController;
  int _currentIndex = 0; //选中下标

    @override
    void initState() {
      super.initState();
      _getData();
      _tabController = TabController(vsync: this, length: myTabs.length);
      _tabController.addListener(() => _onTabChanged());
    }

     /// tab改变监听
  _onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation.value) {
      //赋值 并更新数据
      this.setState(() {
        _currentIndex = _tabController.index;
      });
      _getData();
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
          isScrollable: true,
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
          return Text(tab.text);
        }).toList(),
      )
    );
  }

  Widget noData() {
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

