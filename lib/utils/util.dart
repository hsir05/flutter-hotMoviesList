import 'package:flutter/material.dart';
import 'package:movies/res/resources.dart';
import 'package:flustars/flustars.dart';

class Util {
 static strSplic(List list) {
   if (list != null && list.isNotEmpty) {
      String str = '';
      for (int i = 0; i<= list.length-1; i++) {
        if (i == list.length-1) {
          str += list[i];
        } else {
          str += list[i] + ' / ';
        }
      } 
      return str;
   } else{
     print('缺少参数或参数不正确');
     return '暂无';
   }
  }

  static void showShareModalBottom(context){
     List<Map>shareList = [
        {
          'shareUrl': 'shareUrl',
          'icon': 'images/db.png',
          'name': '豆瓣'
        },
        {
          'shareUrl': 'shareUrl',
          'icon': 'images/weixin.png',
          'name': '微信'
        },
        {
          'shareUrl': 'shareUrl',
          'icon': 'images/QQ.png',
          'name': 'QQ'
        },
        {
          'shareUrl': 'shareUrl',
          'icon': 'images/pyq.png',
          'name': '朋友圈'
        },
        {
          'shareUrl': 'shareUrl',
          'icon': 'images/kj.png',
          'name': '空间'
        },
        {
          'shareUrl': 'shareUrl',
          'icon': 'images/lj.png',
          'name': '复制链接'
        },
      ];
      var icontList = List.generate(shareList.length, (int index) =>
              InkWell(
                  onTap: () {print('微信');},
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset(shareList[index]['icon'], width: ScreenUtil.getInstance().getAdapterSize(40)),
                        Gaps.vGap5,
                        Text(shareList[index]['name'], style: TextStyles.textDarkGray12,)
                      ],
                    ),
                  ),
                ),
          );

      showModalBottomSheet(
            context: context,
            builder: (BuildContext context){
              return Container(
                alignment: Alignment.topLeft,
                height: ScreenUtil.getInstance().getAdapterSize(150),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: icontList,
                ),
              );
            }
        );
  }
}