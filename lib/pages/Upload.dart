import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import '../utils/http.dart';

//继承与动态组件
class WarpDemo extends StatefulWidget {
  _WarpDemoState createState() => _WarpDemoState();
}
class _WarpDemoState extends State<WarpDemo> {
  Future<File> _imageFile;
  List<Widget> list;  //声明一个list数组
  @override
  void initState() { 
    super.initState();
    list = List<Widget>()..add(buildAddButton());
  }

  getImage() {
    // num size = list.length;
    // if (size >= 4) {
    //   Scaffold.of(ctx).showSnackBar(new SnackBar(
    //     content: new Text("最多只能添加4张图片！"),
    //   ));
    //   return false;
    // }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_camera,color: Colors.redAccent,),
              title: Text("Camera"),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  _imageFile = ImagePicker.pickImage(source: ImageSource.camera);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library,color: Colors.redAccent,),
              title: Text("Gallery"),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                    _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
                });
              },
            ),
          ],
        );});
      list.insert(list.length-1, buildPhoto());
      _imageFile = null;
  }

  // 相机拍照或者从图库选择图片
  pickImage(ctx) {
    // 如果已添加了9张图片，则提示不允许添加更多
    num size = list.length;
    if (size >= 4) {
      Scaffold.of(ctx).showSnackBar(new SnackBar(
        content: new Text("最多只能添加4张图片！"),
      ));
      return false;
    }
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext context){
    //     return Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         ListTile(
    //           leading: Icon(Icons.photo_camera,color: Colors.redAccent,),
    //           title: Text("Camera"),
    //           onTap: () {
    //             Navigator.of(context).pop();
    //             getImage('camera');
    //           },
    //         ),
    //         ListTile(
    //           leading: Icon(Icons.photo_library,color: Colors.redAccent,),
    //           title: Text("Gallery"),
    //           onTap: () {
    //             Navigator.of(context).pop();
    //             getImage('gallery');
    //           },
    //         ),
    //       ],
    //     );});
  }

  @override
  Widget build(BuildContext context) {
    //得到屏幕的高度和宽度，用来设置Container的宽和高
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wrap流式布局'),
        backgroundColor: Colors.redAccent
      ),
      body: Opacity(
          opacity: 0.8,
          child: Container(
            width: width,
            height: height,
            child: Wrap(    //流式布局，
              children: list,
              spacing: 26.0,  //设置间距
            ),
          ),
        ),
    );
  }
  Widget buildAddButton(){
    //返回一个手势Widget，只用用于显示事件
    return  GestureDetector(
      onTap:(){
        getImage();
      },
      child: Padding(
        padding:const EdgeInsets.all(4.0),
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Icon(Icons.add,color: Colors.white),
        ),
      ),
    );
  }
  Widget buildPhoto() {
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null && _imageFile != null) {
         
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container( 
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Image.file(snapshot.data, fit: BoxFit.cover),
            ),
          );
        }
        else {
          return Padding(
            padding:const EdgeInsets.all(4.0),
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Icon(Icons.add,color: Colors.white),
            ),
          );
        }
      });
  }
}