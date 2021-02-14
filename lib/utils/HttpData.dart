import 'package:CE.CCSL/page/Login/flutter_login.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
String refresh_token;
BaseOptions options;

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
Future<void> _incrementCounter() async {
  final SharedPreferences prefs = await _prefs;
  refresh_token = prefs.getString('refresh_token');
  // setState(() {
  //   _counter = prefs.setInt("counter", counter).then((bool success) {
  //     return counter;
  //   });
  // });
}

// ignore: non_constant_identifier_names
AuthData() async {
  await _incrementCounter();
  options = BaseOptions(
    baseUrl: "http://api.ceccsl.com",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      'Authorization': 'Basic Q3VzdG9tZXItQVBQOkN1c3RvbWVyLUFQUC1zZWNyZXQ=',
      'Auth-Token': 'bearer $refresh_token',
      //'Auth-Token':'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJMeWRhIE9ubGluZSBTaG9wICggVmVuIEx5ZGEgKSIsInNjb3BlIjpbImFsbCJdLCJjbGllbnQiOiJDdXN0b21lci1BUFAiLCJjdXN0b21lckNvZGUiOiJCQ1BDMTA2ODk1IiwiZXhwIjoxNjA5MjIzODA4LCJqdGkiOiI1MTYzOTUxNS0zZjI3LTRhZDQtOWI3Yi05MDE3MzkzMDE2M2YiLCJjbGllbnRfaWQiOiJDdXN0b21lci1BUFAifQ.IO8PT9nRHGALY9bv1DhsziJ_lTalPknBxZHP9-Em4cI'
    },
    validateStatus: (status) {
      //print(status);
      return true;
    },
  );
}

// 请求组件
// ignore: non_constant_identifier_names
GetHttpUrl({String url, int n, int status}) async {
  if (n == null) {
    BotToast.showLoading();
  }

  await AuthData();
  Dio dio = Dio(options);
  // 强制SSL 证书检测 通过.
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback = (cert, host, port) {
      return true;
    };
  };

  // 发起请求
  var response;
  try {
    response = await dio.get(url);
    //print(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      BotToast.closeAllLoading();
      // 首页不跳转登录 ,返回600 不跳转登录.
      //print(response.data['code'] == 600);

      if (7777 == status) {
        return response.data;
      }
      switch (response.data['code']) {
        case 600:
          print('跳转登录');
          if (response.data['code'] == status) {
            return;
          }
          //Get.toNamed('/LoginScreen');
          Get.offAll(LoginScreen());
          break;
        case 200:
          print('请求成功');
          return response.data;
          break;
        default:
          print('请求失败!');
          break;
      }
    } else {
      BotToast.closeAllLoading();
      BotToast.showText(text: "网络错误".tr);
      print('接口异常');
      return {};
      //throw Exception("接口异常R");
    }
  } catch (e) {
    BotToast.closeAllLoading();
    BotToast.showText(text: "网络错误".tr);

    //print("网络出现错误$e");
    return {};
  }
}

// 请求组件
// ignore: non_constant_identifier_names
PostHttp({String url, Map data, int n}) async {
  if (n == null) {
    BotToast.showLoading();
  }

  await AuthData();
  //showLoadingDialog();
  Dio dio = Dio(options);
  // 强制SSL 证书检测 通过.
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback = (cert, host, port) {
      return true;
    };
  };
  // 发起请求
  var response;
  try {
    response = await dio.post(url, data: data);
    //response = await dio.get(url);
    if (response.statusCode == 200) {
      //BotToast.showSimpleNotification(title: "init");
      //BotToast.showLoading();
      BotToast.closeAllLoading();
      switch (response.data['code']) {
        case 600:
          print('跳转登录');
          //Get.toNamed('/LoginScreen');
          Get.offAll(LoginScreen());
          break;
        case 200:
          print('请求成功');
          return response.data;
          break;
        default:
          print('请求失败!');
          break;
      }
    } else {
      BotToast.closeAllLoading();
      BotToast.showText(text: "网络错误".tr);
      print('接口异常');
      return {};
      //throw Exception("接口异常R");
    }
  } catch (e) {
    BotToast.closeAllLoading();
    BotToast.showText(text: "网络错误".tr);

    print("网络出现错误$e");
    return {};
  }
}
