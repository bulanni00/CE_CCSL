import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:open_appstore/open_appstore.dart';

// ignore: camel_case_types
class LIU_tool {
  // URL 启动设备功能
  static void makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // 打开商店 下载APP
  static void openAppStroe() {
    OpenAppstore.launch(
        androidAppId: "com.wta.NewCloudApp.jiuwei310287",
        iOSAppId: "1537969454");
  }

  static void cupertion() {
    CupertinoPageScaffold(
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
