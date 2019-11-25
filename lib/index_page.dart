import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pages/home_page.dart';
import 'pages/details_page.dart';
import 'pages/my_page.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
   PageController _pageController;

  final List<Widget> tabBodies = [
    HomePage(),
    DetailsPage(),
    MyPage()
  ];
   
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('热映'),
    ),
     BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('找片'),
    ),
     BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('我的'),
    ),
  ];

  int currentIndex = 0;
  var currentPage;
  
  @override
  void initState() {
    currentPage=tabBodies[currentIndex];
    _pageController=new PageController()
      ..addListener(() {
        if (currentPage != _pageController.page.round()) {
          setState(() {
            currentPage = _pageController.page.round();
          });
        }
    });
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: bottomTabs,
          onTap: (index) {
              setState(() {
                currentIndex = index;
                currentPage = tabBodies[currentIndex];
              });
          },
        ),
        body: IndexedStack(
          index: currentIndex,
          children: tabBodies
        )
      );
    }
}