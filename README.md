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