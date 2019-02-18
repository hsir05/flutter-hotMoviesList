import 'package:flutter/material.dart';

/**
 * 下拉刷新、上拉加载
 */
class RefreshListPage extends StatefulWidget {
  @override
  ListViewState createState() {
    return new ListViewState();
  }
}

class ListViewState extends State<RefreshListPage> {
  List<String> _list = [];
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      var position = _scrollController.position;
      // 小于50px时，触发上拉加载；
      if (position.maxScrollExtent - position.pixels < 50) {
        _loadMore();
      }
    });

    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text("下拉刷新,上拉加载"),
      ),
      body: RefreshIndicator(
          color: Colors.deepOrangeAccent,
          backgroundColor: Colors.white,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _list.length == 0
                ? 0
                : isLoading ? _list.length + 1 : _list.length,
            itemBuilder: (context, index) {
              return _getRow(context, index);
            },
          ),
          onRefresh: _onRefresh),
    );
  }

  @override
  void dispose() {
    print("RefreshListPage _dispose()");
    _scrollController?.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    print("RefreshListPage _onRefresh()");
    await Future.delayed(Duration(seconds: 2), () {
      _list = List.generate(15, (i) => "我是刷新出的数据${i}");
      setState(() {});
    });
  }

  void _generateData() async {
    await Future.delayed(Duration(seconds: 2), () {
      print("RefreshListPage _generateData()");
      _list = List.generate(20, (i) => "我是初始化的数据${i}");
      setState(() {});
    });
  }

  bool isLoading = false;

  void _loadMore() async {
    print("RefreshListPage _loadMore()");
    if (!isLoading) {
      isLoading = true;
      setState(() {});
      Future.delayed(Duration(seconds: 3), () {
        print("RefreshListPage isLoading = ${isLoading}");
        isLoading = false;
        _list = List.from(_list);
        _list.addAll(List.generate(5, (index) => "上拉加载个数${index}"));
        setState(() {});
      });
    }
  }

  Widget _getRow(BuildContext context, int index) {
    if (index < _list.length) {
      return ListTile(
        title: Text(_list[index]),
      );
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