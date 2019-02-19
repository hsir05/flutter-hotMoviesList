import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PublishTweetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PublishTweetPageState();
  }
}

class PublishTweetPageState extends State<PublishTweetPage> {

  TextEditingController _controller = TextEditingController();
  List<File> fileList = List();
  Future<File> _imageFile;
  bool isLoading = false;
  String msg = "";

  Widget getBody() {
    // gridView用来显示选择的图片
    var gridView = Builder(
      builder: (ctx) {
        return GridView.count(
          // 分4列显示
          crossAxisCount: 4,
          children: List.generate(fileList.length + 1, (index) {
            // 这个方法体用于生成GridView中的一个item
            var content;
            if (index == 0) {
              var addButton = Container(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.add,color: Colors.white,size: 55.0,),
                );
              content = GestureDetector(
                onTap: () {// 添加图片
                  pickImage(ctx);
                },
                child: addButton,
              );
            } else {// 被选中的图片
              content = Center(
                child: Image.file(fileList[index - 1], width: 80.0, height: 80.0, fit: BoxFit.cover,)
              );
            }
            return Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: const Color(0xFFECECEC),borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: content,
            );
          }),
        );
      },
    );
    var children = [
      Container(
          margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          height: 200.0,
          child: gridView
      )
    ];
    if (isLoading) {
      children.add(new Container(
        margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ));
    } else {
      children.add(new Container(
        margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Center(
          child: Text(msg),
        )
      ));
    }
    return Container(
      child: Column(
        children: children,
      ),
    );
  }

  // 相机拍照或者从图库选择图片
  pickImage(ctx) {
    // 如果已添加了9张图片，则提示不允许添加更多
    num size = fileList.length;
    if (size >= 3) {
      Scaffold.of(ctx).showSnackBar(new SnackBar(
        content: Text("最多只能添加3张图片！"),
      ));
      return;
    }
    showModalBottomSheet<void>(context: context, builder: _bottomSheetBuilder);
  }

  Widget _bottomSheetBuilder(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _renderBottomMenuItem(Icons.photo_camera,"相机拍照", ImageSource.camera),
        _renderBottomMenuItem(Icons.photo_library,"图库选择照片", ImageSource.gallery),
      ],
    );
  }

  _renderBottomMenuItem(icon,title, ImageSource source) {
    // var item = Container(
    //   height: 60.0,
    //   child: Center(
    //     child: Text(title)
    //   ),
    // );
    var item = ListTile(
      leading: Icon(icon,color: Colors.redAccent),
      title: Text(title),
    );
    return InkWell(
      child: item,
      onTap: () {
        Navigator.of(context).pop();
        setState(() {
          _imageFile = ImagePicker.pickImage(source: source);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("照片展示", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          Builder(
            builder: (ctx) {
              return IconButton(icon: Icon(Icons.send), onPressed: () {
                // 发送请求
              });
            },
          )
        ],
      ),
      // 在这里接收选择的图片
      body: FutureBuilder(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null && _imageFile != null) {
            // 选择了图片（拍照或图库选择），添加到List中
            fileList.add(snapshot.data);
            _imageFile = null;
          }
          // 返回的widget
          return getBody();
        },
      ),
    );
  }
}