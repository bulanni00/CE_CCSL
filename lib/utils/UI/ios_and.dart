import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class LIU_ui extends StatelessWidget {
  const LIU_ui({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ios(),
    );
  }

  Widget ios() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.black.withOpacity(.0),
        middle: Material(
          child: Text(''),
        ),
      ),
      child: Material(
          child: Container(
        child: Center(
          child: Text('暂无数据..'),
        ),
      )),
    );
  }
}
