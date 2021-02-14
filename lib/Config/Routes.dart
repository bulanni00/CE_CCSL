import 'package:CE.CCSL/page/Home/HomePage.dart';
import 'package:CE.CCSL/page/Login/flutter_login.dart';
import 'package:CE.CCSL/page/News/detail.dart';
import 'package:CE.CCSL/page/News/newsList.dart';
import 'package:CE.CCSL/page/SaoMa/saoMa2.dart';
import 'package:CE.CCSL/page/Tabs.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/', page: () => Tabs()),
  GetPage(name: '/HomePage', page: () => HomePage()),
  GetPage(name: '/SaoMa', page: () => CustomSizeScannerPage()),
  GetPage(name: '/News', page: () => News()),
  GetPage(name: '/News/detail', page: () => Detail()),
  GetPage(name: '/Login', page: () => LoginScreen()),
];
