import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/widget/video_widget.dart';
import 'package:movies/res/resources.dart';


class TrailerViderPlayPage extends StatelessWidget {

  // bloopers
  // trailers

  // Widget _getContentVideo() {
  //   return VideoWidget( 
  //     movDetail.trailers[0].resource_url,
  //     showProgressBar: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Colours.bg_detail_color,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
                Navigator.pop(context);
            }), 
        centerTitle: true),
        body: Container(
          child: Text('data'),
        ),
    );
  }
}