import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flustars/flustars.dart';
import 'package:movies/res/resources.dart';

 final List<Tab> myTabs = <Tab>[
    Tab(text: '想看'),
    Tab(text: '在看'),
    Tab(text: '看过'),
    Tab(text: '影评'),
    Tab(text: '影人'),
  ];

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>with SingleTickerProviderStateMixin {
  bool loading = true;
  int _currentIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(() => _onTabChanged());
  }

   _onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation.value) {
      print("======+++++=====");
       loading = true;
      _currentIndex = _tabController.index;
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: PreferredSize(
        preferredSize: Size(130, 130),
        child: AppBar(
          backgroundColor: Colours.bg_avatar,
          title: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 26.0,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('images/ic_default_img_subject_movie.8.png'),
                      )
                    ],
                  ),
                ),

                Container(
                  width: 80.0,
                  child: Icon(Icons.settings, size: 22.0, ),
                )
              ],
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
            indicatorColor: Colors.white,
            onTap: (int i){
              print(444);
            },
          ),
        ),
      ),
      body:TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return Text(tab.text);
        }).toList(),
      )
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}