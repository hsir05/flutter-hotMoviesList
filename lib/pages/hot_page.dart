import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/http.dart';
import './MoviesDetails.dart';


class HotPage extends StatefulWidget {
  final String title = 'Movies';

  @override
  _HotPageState createState() => _HotPageState();
}
 
class _HotPageState extends State<HotPage> {
  List subjects = [];
  String title = '';
  int start = 0;
  int count = 20;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState () {
    super.initState();

     _scrollController.addListener(() {
      var position = _scrollController.position;
      if (position.maxScrollExtent - position.pixels < 50) {
        _loadMore();
      }
    });
    getInitData();
  }

  @override
  void dispose() {
    print("RefreshListPage _dispose()");
    _scrollController?.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      getInitData();
    });
  }

  bool isLoading = false;

  void _loadMore() async {
    print("RefreshListPage _loadMore()");
    if (!isLoading) {
      isLoading = true;
      setState(() {});
      Future.delayed(Duration(seconds: 3), () {
        isLoading = false;
        getMoreData();
      });
    }
  }

  void getInitData() async{
    try {
      var result = await Http().get("https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&start=0&count=100",data: {});
      setState(() {
        title = result['title'];
        subjects = result['subjects'];
      });
    }catch(e){
      print(e);
    }
  }

  void getMoreData () async{
    try {
      var result = await Http().get("https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=${start + 1}&count=100",data: {});
      setState(() {
        start = start + 1;
        subjects.addAll(result['subjects']);
      });
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: RefreshIndicator(
        color: Colors.deepOrangeAccent,
        backgroundColor: Colors.white,
        child: getBody(),
        onRefresh: _onRefresh
        ),
    );
  }
  
  getItem(var subject) {
    //    演员列表
    var details = subject;
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
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
          return new MoviesDetails(details:details);
        }));
      },
    );
  }

  getBody() {
    if (subjects.length != 0) {
      return ListView.builder(
        controller: _scrollController,
        itemCount: subjects.length == 0
            ? 0
            : isLoading ? subjects.length + 1 : subjects.length,
        itemBuilder: (context, index) {
          return _getRow(context, index);
        },
      );
    } else {
      return Center( child: CupertinoActivityIndicator());
    }
  }

  Widget _getRow(BuildContext context, int index) {
    

    if (index < subjects.length) {
      return getItem(subjects[index]);
    }
    return _getMoreWidget();
  }

  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                '加载中...',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

}