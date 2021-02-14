import 'package:CE.CCSL/page/Home/HomePage.dart';
import 'package:CE.CCSL/page/News/newsList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return _iosScaffold();
  }

  // IOS Scaffold 风格
  _iosScaffold() {
    return CupertinoTabScaffold(
      backgroundColor: Colors.grey[50],
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.black.withOpacity(.0),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // ignore: deprecated_member_use
            title: Text('首页'.tr),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            // ignore: deprecated_member_use
            title: Text('通知'.tr),
          )
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          // ignore: missing_return
          builder: (context) {
            switch (index) {
              case 0:
                return HomePage();
                break;
              case 1:
                return News();
                break;
              default:
            }
          },
        );
      },
    );
  }

  // List _pageList = [
  //   HomePage(),
  //   HomePage(),

  //   //Profile(),
  // ];
  // int _currentIndex = 0;
  // _andScaffold() {
  //   return Scaffold(
  //     body: this._pageList[this._currentIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       backgroundColor: Colors.black.withOpacity(.0),
  //       elevation: 0,
  //       currentIndex: this._currentIndex,
  //       onTap: (int index) {
  //         setState(() {
  //           this._currentIndex = index;
  //         });
  //       },
  //       items: [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home_outlined),
  //           label: '首页',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.search_outlined),
  //           label: '查询',
  //         )
  //       ],
  //     ),
  //   );
  // }
}
