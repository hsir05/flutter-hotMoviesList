### 说明

文章参考自某位大神

### 1. flutter 跳转第二页后没有出现返回按钮

 + 1. 页面跳转的时候，跳转了两层，到达第三个页面，此时按Android自带的返回键，会跳回到第一个页面，而不是第二个页面。
经过观察其他的demo，**将页面的StatelessWidget改成StatefulWidge就解决了。**

+ 2. 第二个第三个页面不出现返回按钮的问题，**一个MaterialApp是最简单的设置方式，MaterialApp的home成为导航器堆栈底部的路由。移除第二个，第三个界面上的MaterialApp，直接使用Scaffold就好了！**

### 2. 跳转

 + 1. 跳转到第二页**

```
Navigator.push( context,
  new MaterialPageRoute(builder: (context) => new SecondScreen()),
);
```

+ 2. 返回

```
Navigator.pop(context);
```

### 3. 手势处理 `GestureDetector`

```
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onLongPress: null,  // 长按事件
      onTap: () {  // 单击事件
        Scaffold.of(context).showBottomSheet((BuildContext context) {
          return new Container(
            color: Color(0xffff639b),
            width: double.infinity,
            height: 100.0,
            child: new Center(
              child: Text('I\'m Bottom Sheet'),
            ),
          );
        });
      },
      onDoubleTap: () {  // 双击事件
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('I\'m Snack Bar')));
      },
      child: new Container(
        padding: new EdgeInsets.all(12.0),
        child: new Text('Custom Button'),
      ),
    );
  }
}
```
该控件还包括以下事件和方法

```
child
onTapDown
onTapUp
onTap
onTapCancel
onDoubleTap
onLongPress
onVerticalDragDown
onVerticalDragStart
onVerticalDragUpdate
onVerticalDragEnd
onVerticalDragCancel
onHorizontalDragDown
onHorizontalDragStart
onHorizontalDragUpdate
onHorizontalDragEnd
onHorizontalDragCancel
onPanDown
onPanStart
onPanUpdate
onPanEnd
onPanCancel
onScaleStart
onScaleUpdate
onScaleEnd
```

### 5. 头像控件

`CircleAvatar`

### 6. 安卓发布版SHA1获取

[参考文章](https://blog.csdn.net/qq_29269233/article/details/53725865)

### 7. 集成高德地图

[参考文章](https://segmentfault.com/a/1190000016342825)
[参考文章](https://blog.csdn.net/a1057962851/article/details/86024154)

### 8. 集成蓝牙

[参考文章](https://pub.dartlang.org/packages/flutter_blue)


### 9. flutter 常用插件

[常用库](https://blog.csdn.net/szintu/article/details/82666335)

```
audio_recorder: any #录音、播放
  flutter_sound: ^1.1.5#录音
  dropdown_menu: ^1.1.0#下拉菜单
  simple_permissions:#权限获取
  easy_alert:#弹框
  amap_location: any #高德地图
  location: any #gogle位置获取
  barcode_scan 0.0.8#二维码识别qr_mobile_vision: ^0.1.0 #二维码识别 这个不好用
  flutter_screenutil: ^0.3.0#屏幕适配工具类  
  flutter_spinkit: ^2.1.0#加载等待框
  lpinyin: ^1.0.6#汉字转拼音
  shimmer: ^0.0.4#微光效果控件
  qr_flutter: ^1.1.3#二维码生成
  url_launcher: any#启动URL的Flutter插件。支持网络，电话，短信和电子邮件
  datetime_picker_formfield: ^0.1.3#时间选择控件
  flutter_picker: '^1.0.0'#选择器
  common_utils: '^1.0.1'#工具类 时间、日期、日志等
  flutter_html: '^0.8.2'#静态html标记呈现为Flutter小部件
  fluwx: '^0.3.0'#微信支付、分享、登录
  tobias: '^ 0.0.6#支付宝
  cupertino_icons: '^0.1.2'#小图标控件
  http: '^0.11.3+16'#网络请求
  html: '^0.13.3'#html解析
  image_picker: '^0.4.5'#图片选择（相册或拍照）
  flutter_webview_plugin: any#webview展示
  fluttertoast: any#toast提示框
  shared_preferences: '^0.4.2'#shared_preferences存储
  transparent_image: '^0.1.0'#透明图片控件
  flutter_swiper : '^1.0.2'#轮播图
  charts_flutter: '^0.4.0'#统计图表
  path_provider: '^0.4.1'#获取系统文件
  cached_network_image: '0.4.1'#加载网络图片并本地缓存
  sqflite: '^0.11.0+1'#sqllite数据库操作
  pull_to_refresh: '^1.1.5'#下拉刷新上拉加载更多
  video_player: '0.6.1'#视频播放
  collection: '1.14.11'#集合操作工具类
  device_info: '0.2.1'#获取手机信息
  flutter_svg: '^0.3.2'#展示svg图标控件
  intl: any#国际化工具类
  connectivity: '0.3.1'#链接网络
  flutter_staggered_grid_view:#瀑布流展示控件
  flutter_file_manager:#文件管理
  loader_search_bar:#导航栏搜索控件
  flutter_image_compress : any#图片压缩
  ota_update : any#App下载更新
  flutter_slidable：#item侧滑控件
```
[参考文章1](https://blog.csdn.net/weixin_30512027/article/details/84381611)
[参考文章2](https://www.jianshu.com/p/c78ef5cf7f6a)

### 10. 获取屏幕宽高

```
final width = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;
```

### 11 . 日期组件国际化

+ 1.添加包

   `flutter_localizations:`

+ 2.导包 

  `import 'package:flutter_localizations/flutter_localizations.dart';`

+ 3. 设置
  
  ```
    void main() {
    runApp(
      new MaterialApp(
        title: 'app',
        theme: new ThemeData(
          primaryColor: Colors.white,
        ),
        home: new MyLoginWidget(),
        localizationsDelegates: [
          //此处
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          //此处
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
      ),
    );
  }
  ```
  要显示中文控件设置
  `locale: Locale('zh'),`

### 12. 获取发布版SHA1值

` keytool -list -v -keystore D:\key.jks`