import 'package:bot_toast/bot_toast.dart';
import 'package:CE.CCSL/Config/Routes.dart';
import 'package:CE.CCSL/Locale/Messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  return runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(), //翻译文件
      locale: Locale('ca', 'KH'), //初始翻译
      //fallbackLocale: Locale('zh', 'CN'), //不存在时 备用翻译
      builder: BotToastInit(), //初始化提示库
      navigatorObservers: [BotToastNavigatorObserver()], //提示库
      debugShowCheckedModeBanner: false, //关闭dubug 图标
      initialRoute: '/', //初始 执行路由.
      theme: ThemeData(
          //主题样式
          //platform: TargetPlatform.iOS,
          ),
      getPages: routes, //路由文件
    );
  }
}
