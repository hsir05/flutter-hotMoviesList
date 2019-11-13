import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flustars/flustars.dart';
import 'package:movies/res/resources.dart';
import 'package:movies/widget/loading_widget.dart';
import './searchBar.dart';
import '../service/service_method.dart';
// import '../model/hot_model.dart';
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
  List<Subject> topList = [];
  List<SubjectEntity> weeklyBeans = List();
  List<SubjectEntity> northAmerica = List();
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
      return request('hotPageContext', {'start': 0, 'count': 5});
    }).then((result) {
      print('数据加载完成');
      var resultList = result['subjects'];
      setState(() {
        hotList =resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        loading = false;
      });
    });
    _getTopData();
    _getOpinionsData();
  }

  void _getTopData() {
    request('top250Context', null).then((result){
        var resultList = result['subjects'];
         List<Subject> data = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        setState(() {
          loading = false;
          topList = data;
          });
    }); 
  }

  void _getOpinionsData() {
      request('opinionsContext', null).then((result){
        print('++++++++++++++');
        var resultList = result['subjects'];
        List<SubjectEntity> list = resultList
        .map<SubjectEntity>((item) => SubjectEntity.fromMap(item))
        .toList();

        setState(() {
          loading = false;
          weeklyBeans = list;
          });
      }); 
  }
  void _northAmerica() {
    request('northAmericaContext', null).then((result){
        print('++++++++++++++');
        var resultList = result['subjects'];
        List<SubjectEntity> list = resultList
        .map<SubjectEntity>((item) => SubjectEntity.fromMap(item))
        .toList();

        setState(() {
          loading = false;
          northAmerica = list;
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
         return ListView(
           children: <Widget>[
              // Divider(),
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: _part('找电影', '冷门/豆瓣评分', Icon(Icons.list, color: Colors.white,), Colors.purple, (){
              //         print('找电影, 冷门/豆瓣评分/动作');
              //       }),
              //     ),
              //     Container(
              //       width: ScreenUtil.getInstance().getAdapterSize(160),
              //       child: _part('我的影视', '未登录', Icon(Icons.favorite_border, color: Colors.white,), Colours.icon_heart, (){
              //         print('我的影视');
              //       }),
              //     )
              //   ],
              // ),
              Divider(),
              title('豆瓣热映'),
              Divider(),
              LoadingWidget.containerLoadingBody(_hotMovies(hotList), loading: loading),
       
              ListTile(
                title: Text('豆瓣电影Top250', style: TextStyles.textBold18,),
              ),
              Divider(),
              LoadingWidget.containerLoadingBody(_topContent(), loading: loading),
              Text('全部250', style: TextStyles.textSize12, textAlign: TextAlign.center,),

              ListTile(
                title: Text('本周口碑榜', style: TextStyles.textBold18,),
              ),
              LoadingWidget.containerLoadingBody(_optContent(), loading: loading),

              ListTile(
                title: Text('北美票房榜', style: TextStyles.textBold18,),
              ),
           ],
         );
        }).toList(),
      )
    );
  }

  Widget _optContent(){
    if (weeklyBeans.length  == 0) {
        return Container(
            child: Text(''),
          );
    }
   return GridView.builder(
          shrinkWrap: true,
          itemCount: weeklyBeans.length,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return _optItem(weeklyBeans[index]);
          },
        );
  }

  Widget _optItem(bean) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(
                bean.subject.images.small, 
                height: ScreenUtil.getInstance().getAdapterSize(120),
                fit: BoxFit.fill,
              ),
            ),
            Gaps.vGap4,
            Text(bean.subject.title, style: TextStyles.textBold12, overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }

  Widget _topContent() {
    if (topList.length != 0) {
      List<Widget>listWidget = topList.map((val){
          return ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.network(
                    val.images.large, 
                    width: ScreenUtil.getInstance().getAdapterSize(35), 
                    height: ScreenUtil.getInstance().getAdapterSize(45),
                    fit: BoxFit.fill,
                  ),
                ),
              title: Text(val.title, style: TextStyles.textBold14),
              subtitle: Text( '豆瓣评分：${val.rating.average}', style: TextStyles.textSize12),
            );
            }).toList();
          return Wrap(
            spacing: 2,
            children: listWidget,
          );
    } else {
      return Text('');
    }
  }

  Widget _hotMovies(list) {
    if (list.length  == 0) {
        return Container(
            child: Text(''),
          );
    }

    return Container(
      height: ScreenUtil.getInstance().getAdapterSize(220.0),
      color: Colours.bg_gray,
      child: ListView.builder(
        padding: new EdgeInsets.all(5.0),
        physics: const BouncingScrollPhysics(),
         itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index){
          Subject bean = list[index];
          return _getItem(bean);
        },
      ),
    );
  }

  Widget _getItem(Subject bean) {
      return Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                        bean.images.large, 
                        width: ScreenUtil.getInstance().getAdapterSize(95), 
                        height: ScreenUtil.getInstance().getAdapterSize(135),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Gaps.vGap4,
                    Text(bean.title, style: TextStyles.textBold12,),
                    Gaps.vGap4,
                    Text( '豆瓣评分：${bean.rating.average}', style: TextStyles.textSize12,),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                    color: Colours.icon_bg,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(3.0), bottomRight: Radius.circular(3.0)),
                  ),
                    child: Icon(Icons.favorite_border, color: Colors.white, size: 20.0,),
                  )
                  ),
              ],
            )
          ],
        )
      );
  }

  Widget title(String title){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left:20.0 ,top: 10.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(title, style: TextStyles.textBold18)),
        
          Container(
            width: ScreenUtil.getInstance().getAdapterSize(90),
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