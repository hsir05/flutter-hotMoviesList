import 'package:flutter/material.dart';
import '../utils/http.dart';
import 'package:flutter/cupertino.dart';

// class MoviesDetails extends StatelessWidget {
//   final details;
//   MoviesDetails({Key key, @required this.details}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${details['title']}'),
//       ),
//       body: Center(
//         child: Content(content:details),
//       )
//     );
//   }
// }

class MoviesDetails extends StatefulWidget {
  final details;
  MoviesDetails({this.details});

  @override
  _MoviesDetailsState createState() {
    return _MoviesDetailsState();
  }
}

class _MoviesDetailsState extends State<MoviesDetails> {
  var movDetail = {};

  @override
  void initState () {
    super.initState();
    getHttp();
  }
  void getHttp() async{
    try {
      var result = await Http().get("https://api.douban.com/v2/movie/${widget.details['id']}",data: {});
      setState(() {
        movDetail = result;
      });
    }catch(e){
      return print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.details['title']}'),
      ),
      body: Center(
        child: ContentArea(content:widget.details, movDetail: this.movDetail),
      )
    );
  }
}

class ContentArea extends StatelessWidget {
  var content;
  var movDetail = {};
  ContentArea({Key key, @required this.content, @required this.movDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var castList = List.generate(content['casts'].length, (int index) =>
        Container(
          margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 8.0),
          child: Center(
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(content['casts'][index]['avatars']['small'],height: 150.0,),
                ),
                Text(content['casts'][index]['name'])
              ],
            ),
          )
        ),
    );

    getTags () {
      int len = movDetail['tags'] != null ? movDetail['tags'].length : 0;
      if (len != 0) {
        var tags = List.generate(len, (int index) => 
           Container(
              padding: EdgeInsets.all(5.0),
              // color: Colors.redAccent,
              height: 30.0,
              width: 100.0,
              alignment: Alignment.bottomLeft,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.grey, width: 1.0),
              //   borderRadius: BorderRadius.all(Radius.circular(2.0)),
              // ),
              child: Text('${movDetail['tags'][index]['name']}',style: TextStyle(fontSize: 16.0), textAlign:TextAlign.center ,),),
        );
        return Wrap(direction: Axis.horizontal,alignment: WrapAlignment.start,children: tags,);
      } else {
        return CupertinoActivityIndicator();
      }
    }
    
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
            children: <Widget>[
              Container(
                width: 130.0,
                margin: EdgeInsets.only(right: 10.0),
                child:ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(content['images']['small'], fit: BoxFit.contain,),
              )
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(content['title'], style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                    Text( '导演：${content['directors'][0]['name']}' ),
                    Text( "类型：${content['genres'].join("、")}" ),
                    // Text( "上映时间：${movDetail['attrs']['pubdate']}" ),
                    // Text("${movDetail['attrs']['movie_duration']} ${movDetail['attrs']['language']}"),
                    Text('${content['collect_count']} 人想看'),
                    Text('豆瓣评分 ${content['rating']['average']}'),
                  ],
                ),
              )
            ],
          ),),
          // 标签
          Container(
            padding: EdgeInsets.all(10.0),
            width: 100.0,
            child: Text('标签',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: getTags(),
          ),
          // 电影介绍
          Padding(
            padding: EdgeInsets.only(top:15.0,left: 10.0,right: 10.0),
            child: Text('介绍',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700)),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('${movDetail['summary']}',style: TextStyle(fontSize: 16.0,)),
          ),
          // 演职人员
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0),
            child: Text('主演',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          ),
          Divider(),
          Container(
            height:200.0,
            margin: EdgeInsets.only(left:10.0,top: 10.0),
            child:new ListView(
              scrollDirection: Axis.horizontal,
              children: castList,
            )
          ),
          Divider(),
        ],
      ),
    );
  }
}
