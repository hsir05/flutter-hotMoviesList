import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flustars/flustars.dart';
import 'package:ybpt/res/resources.dart';
import 'package:ybpt/constant/constant.dart';
import 'package:ybpt/widget/loading_widget.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:provide/provide.dart';
import '../provide/location.dart';
import 'package:fluro/fluro.dart';
import './searchBar.dart'; 
import '../service/service_method.dart';
import '../model/hot_model.dart';
import '../routers/application.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with AutomaticKeepAliveClientMixin {

  List<Subject> hotList = [];
  List<Subject> comingSoonList = [];
  List<Subject> list = [];

  TabController _tabController;
  ScrollController _scrollController = new ScrollController();

  int _currentIndex = 0;
  bool loading = true;

  int hotStart = 0;
  int count = 5;

  final List<Tab> myTabs = <Tab>[
    Tab(text: '正在热映'),
    Tab(text: '即将上映'),
  ];

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: ScrollableState());
    _tabController.addListener(() => _onTabChanged());
    _getData({'city': '北京', 'start': hotStart, 'count': count, 'apikey': '0b2bdeda43b5688921839c8ecb20399b'});

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        if (_currentIndex == 0) {
          var data = {
            'start': hotStart + count + 1, 
            'count': count, 
            'apikey': '0b2bdeda43b5688921839c8ecb20399b'
          };
          _getData(data);
        }
      }
    });
  }

  _onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation.value) {
      this.setState(() {
        list = [];
        _currentIndex = _tabController.index;

        if(_currentIndex == 0 && hotList.length == 0) {
         loading = true;
          _getData({'start': 0, 'count': count, 'apikey': '0b2bdeda43b5688921839c8ecb20399b'});
        } else if (_currentIndex == 0 && hotList.length != 0) {
          list = hotList;
        } else if (_currentIndex == 1 && comingSoonList.length != 0) {
          list = comingSoonList;
        } else {
          loading = true;
          _getData(null);
        }
      });
    }
  }

   Future  _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('下拉刷新');
      if (_currentIndex == 0) {
        setState(() {
          hotStart = 0;
        });
      }
      
      _getData({'start': 0, 'count': count, 'apikey': '0b2bdeda43b5688921839c8ecb20399b'});
    });
  }

  void _getData(params){
    String url;
    if(_currentIndex == 0) {
        url = 'hotPageContext';
    } else {
        url = 'upComContext';
    }
    print('参数params-->$params');

    request(url, params).then((result){
        var resultList = result['subjects'];
        List<Subject> data = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
        setState(() {
          if (_currentIndex == 0) {
            if (params['start'] == 0) {
              hotList = data;
            } else {
              hotList.addAll(data);
            }
            list = hotList;

            if (data.length != 0) {
              hotStart = params['start'];
            }
           
          } else {
            comingSoonList = data;
            list = comingSoonList;
          }

          loading = false;
        });
    }); 
  }

  @override
  Widget build(BuildContext context) {
     super.build(context);
    return Provide<Location>(
      builder: (context, child, data){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Container(
                  width: 75.0,
                  child: InkWell(
                    onTap: () async{
                      Result result = await CityPickers.showCitiesSelector(context: context,);
                      print('-------------'); 
                      print(result);
                      var data = {
                        "cityName": result.cityName,
                        "cityId": result.cityId
                      };
                      Provide.value<Location>(context).getLocation(data);
                      _getData({'city': result.cityName, 'start': 0, 'count': count, 'apikey': '0b2bdeda43b5688921839c8ecb20399b'});

                    },
                    child: Row(
                        children: <Widget>[
                        Container(
                          width: ScreenUtil.getInstance().getAdapterSize(35),
                          child: Text(data.location['cityName'], style: TextStyles.textBlockBold12, overflow: TextOverflow.ellipsis,),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colours.text, size: ScreenUtil.getInstance().getAdapterSize(12)
                        )
                      ],),
                  ),
                ),
            title: Container(
              width: ScreenUtil.getInstance().screenWidth,
              child:   
              // InkWell(
              //     onTap: (){
              //       showSearch(context: context,delegate: SearchBarDelegate());
              //     },
              //     child: Container(
              //       height: 40.0, 
              //       padding: EdgeInsets.only(left: 5.0),
              //       decoration: BoxDecoration(
              //         color: Colours.bg_color,
              //         borderRadius: BorderRadius.all(new Radius.circular(5.0)),
              //         border: Border.all(width: 1.0, color: Colors.white)
              //       ),
              //       child: Row(
              //         children: <Widget>[
              //           Icon(Icons.search, color: Colors.black26,),
              //           Text('电影/电视剧/影人', style: TextStyle(fontSize: 14.0, color: Colors.black26),)
              //         ],
              //       ),
              //     ),
              //   ),
              
              
              Row( 
              children: <Widget>[ 
                Container(
                  width: 75.0,
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () async{
                      print('地址');
                      Result result = await CityPickers.showCitiesSelector(context: context,);
                      var data = {
                        "cityName": result.cityName,
                        "cityId": result.cityId
                      };
                      Provide.value<Location>(context).getLocation(data);
                      _getData({'city': result.cityName, 'start': 0, 'count': count, 'apikey': '0b2bdeda43b5688921839c8ecb20399b'});

                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                        SizedBox(child: Text(data.location['cityName'], style: TextStyles.textBlockBold12, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,)),
                        Expanded(
                          child: Icon(Icons.arrow_drop_down, color: Colours.text, size: ScreenUtil.getInstance().getAdapterSize(14)),
                        )
                      ],),
                    ),
                  ),
                ),
               Expanded(
                 child: 
                 InkWell(
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
                )
              ],
             ),
            ),
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              tabs: myTabs,
              onTap: (int i){
                setState(() {
                  list = [];
                });
              },
              labelColor: Colours.text,
            ),
          ),
          body:  TabBarView(
            controller: _tabController,
            children: myTabs.map((Tab tab) {
              return LoadingWidget.containerLoadingBody(_getBody(list), loading: loading);
            }).toList(),
          )
        );
      }
    );
  }

  Widget _getBody(list) {
    if (loading) {
      return Container(
        child: Center(child: CupertinoActivityIndicator(),),
      );
    }
    return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              Subject bean = list[index];
              return Padding(
                padding: const EdgeInsets.only(right: Constant.MARGIN_RIGHT, left: 6.0, top: 13.0),
                child: _getItem(bean, index),
              );
            },
          )
        );
  }

  Widget _getItem(Subject bean, int index) {
    var avatars = List.generate(bean.casts.length, (int index) =>
        Container(
          margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 16.0),
            width: ScreenUtil.getInstance().getAdapterSize(20), 
            height: ScreenUtil.getInstance().getAdapterSize(20),
          child: CircleAvatar(
              backgroundColor: Colors.white10,
              backgroundImage: 
              bean.casts[index].avatars == null ?  AssetImage("images/ic_default_img_subject_movie.8.png") : NetworkImage( 
                bean.casts[index].avatars.small 
              )
          ),
        ),
    );
    return GestureDetector(
      onTap: () {
        Application.router.navigateTo(context,"/movieDetail?id=${bean.id}", transition: TransitionType.inFromRight);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(
                bean.images.large, 
                width: ScreenUtil.getInstance().getAdapterSize(100), 
                height: ScreenUtil.getInstance().getAdapterSize(140),
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
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
