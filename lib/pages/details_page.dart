import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:movies/widget/loading_widget.dart';
import 'package:flustars/flustars.dart';
import 'package:movies/res/resources.dart';
import 'package:movies/constant/constant.dart';
import 'package:movies/widget/loading_widget.dart';
import './searchBar.dart';
import '../service/service_method.dart';
import '../model/hot_model.dart';

 final List<Tab> tabs = <Tab>[
    Tab(text: '电影'),
    Tab(text: '电视剧'),
  ];

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>with SingleTickerProviderStateMixin {
List<Subject> hotList = [];
  List<Subject> comingSoonList = [];
  List<Subject> list = [];
  TabController _tabController;
  int _currentIndex = 0;
  bool loading = true;

 @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController.addListener(() => _onTabChanged());

    Future(() {
      return request('hotPageContext', null);
    }).then((result) {
      print('数据加载完成');
      var resultList = result['subjects'];
      setState(() {
        hotList =resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        loading = false;
      });
    });
  }

_onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation.value) {
      //赋值 并更新数据
      this.setState(() {
        // loading = true;
        _currentIndex = _tabController.index;
        // _getData(url);
      });
    }
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
          tabs: tabs,
          onTap: (int i){
            print(i);
          },
          labelColor: Colours.text,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((Tab tab) {
         return Column(
           children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _part('找电影', '冷门/豆瓣评分', Icon(Icons.list, color: Colors.white,), Colors.purple, (){
                      print('找电影, 冷门/豆瓣评分/动作');
                    }),
                  ),
                  Container(
                    width: ScreenUtil.getInstance().getAdapterSize(160),
                    child: _part('我的影视', '未登录', Icon(Icons.favorite_border, color: Colors.white,), Colours.icon_heart, (){
                      print('我的影视');
                    }),
                  )
                ],
              ),
              Divider(),
              title('豆瓣热映'),
              Divider(),
              LoadingWidget.containerLoadingBody(_hotMovies(hotList), loading: loading),
           ],
         );
        }).toList(),
      )
    );
  }

  Widget _hotMovies(list) {
    if (list.length  == 0) {
        return Container(
            child: Text(''),
          );
    }

    return Container(
      height: ScreenUtil.getInstance().getAdapterSize(150.0),
      child: ListView.builder(
        padding: new EdgeInsets.all(5.0),
        physics: const BouncingScrollPhysics(),
         itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context,int index){
          Subject bean = list[index];
          return _getItem(bean);
        },
      ),
    );
  }

  Widget _getItem(Subject bean) {
      return Container(
        margin: EdgeInsets.all(10.0),
        height: ScreenUtil.getInstance().getAdapterSize(130),
        child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.network(
                    bean.images.large, 
                    width: ScreenUtil.getInstance().getAdapterSize(85), 
                    height: ScreenUtil.getInstance().getAdapterSize(130),
                    fit: BoxFit.fill,
                  ),
                ),
      );
  }

  Widget title(String title){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left:20.0 ,top: 10.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(title, style: TextStyles.textBold24,)),
        
        Container(
          width: ScreenUtil.getInstance().getAdapterSize(80),
          child: InkWell(
          onTap: (){print(123);},
          child: Row(children: <Widget>[
            Text('全部99+ ', style: TextStyles.textBold14),
            Icon(Icons.keyboard_arrow_right)
          ],)
        ),
        )
        
      ],)
    );
  } 
 
  Widget _part(String title, String subtitle, icon, color, onTap) {
    return ListTile(
          leading: CircleAvatar(child: icon, backgroundColor: color, ),
          title: Text(title, style: TextStyles.textBold14,),
          subtitle: Text(subtitle, style: TextStyles.textSize12,),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap:onTap,
        );
  }

}