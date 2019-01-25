import 'package:flutter/material.dart';

class MoviesDetails extends StatelessWidget {
  final details;

  MoviesDetails({Key key, @required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${details['title']}'),
      ),
      body: Center(
        child: Content(content:details),
      )
    );
  }
}

class Content extends StatelessWidget {
  final content;
  Content({Key key, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var castList = List.generate(content['casts'].length, (int index) =>
        Container(
          margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 8.0),
          child: Center(
            child: Column(
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
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
            children: <Widget>[
              Container(
                width: 110.0,
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
                    Text('${content['collect_count']} 人想看'),
                    Text('豆瓣评分 ${content['rating']['average']}'),
                  ],
                ),
              )
            ],
          ),),
          // 演职人员
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0),
            child: Text('主演',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          ),
          Divider(),
          Container(
            height:200.0,
            margin: EdgeInsets.only(top: 10.0),
            child:new ListView(
              scrollDirection: Axis.horizontal,
              children: castList,
            )
          ),
          Divider(),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.all(10.0),
      //       child: Row(
      //       children: <Widget>[
      //         Container(
      //           width: 110.0,
      //           margin: EdgeInsets.only(right: 10.0),
      //           child:ClipRRect(
      //           borderRadius: BorderRadius.circular(6.0),
      //           child: Image.network(content['images']['small'], fit: BoxFit.contain,),
      //         )
      //         ),
      //         Expanded(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: <Widget>[
      //               Text(content['title'], style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
      //               Text( '导演：${content['directors'][0]['name']}' ),
      //               Text( "类型：${content['genres'].join("、")}" ),
      //               Text('${content['collect_count']} 人想看'),
      //               Text('豆瓣评分 ${content['rating']['average']}'),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),),
      //     // 演职人员
      //     Padding(
      //       padding: EdgeInsets.only(top: 15.0, left: 15.0),
      //       child: Text('主演',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
      //     ),
      //     Divider(),
      //     Container(
      //       height:200.0,
      //       margin: EdgeInsets.only(top: 10.0),
      //       child:new ListView(
      //         scrollDirection: Axis.horizontal,
      //         children: castList,
      //       )
      //     ),
      //     Divider(),
      //   ],
      // ),
    );
  }
}
