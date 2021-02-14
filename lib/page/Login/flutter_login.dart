import 'package:CE.CCSL/page/Tabs.dart';
import 'package:CE.CCSL/utils/HttpData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
//import 'dashboard_screen.dart';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:get/get.dart' as g;
import 'package:shared_preferences/shared_preferences.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) async {
    var log = await _getLogin(data);
    print(log);
    print('log');
    //print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (log == 'ok') {
        //登录成功 跳转
        return null;
      } else {
        return 'Password does not match';
      }
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      messages: LoginMessages(usernameHint: 'Name'),
      //showDebugButtons: true,
      title: '',
      logo: 'assets/images/logo.png',
      onLogin: _authUser, //点击登录
      onSignup: _authUser, //点击注册
      //emailValidator: FormFieldValidator(context),
      onSubmitAnimationCompleted: () {
        print('登录跳转');
        //g.Get.toNamed('/');
        g.Get.off(Tabs());
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (context) => DashboardScreen(),
        //     ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    // ignore: deprecated_member_use
    return double.parse(s, (e) => null) != null;
  }

  // 请求组件
  _httpData(data) async {
    BaseOptions options = BaseOptions(
      baseUrl: "https://tms-api.cambodianexpress.com",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        'Authorization': 'Basic Q3VzdG9tZXItQVBQOkN1c3RvbWVyLUFQUC1zZWNyZXQ=',
        //'Content-Type': 'application/x-www-form-urlencoded',
      },
      validateStatus: (status) {
        //print(status);
        return true;
      },
    );

    Dio dio = Dio(options);
    // 强制SSL 证书检测 通过.
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
    //print('wozhidddd');
    FormData formData;
    if (isNumeric(data.name)) {
      //LoginData data = '855${data.name}';
      formData = FormData.fromMap({
        "username": '855${data.name}',
        "password": data.password,
        "grant_type": "password"
      });
    } else {
      formData = FormData.fromMap({
        "username": data.name,
        "password": data.password,
        "grant_type": "password"
      });
    }

    print(data);
    String url = '/api/ios/blade-auth/oauth/token';
    // 发起请求

    var response = await dio.post(url, data: formData);

    if (response.statusCode == 400) {
      print('用户名或者密码错误');
      return '用户名或者密码错误!'.tr;
    }
    if (response.statusCode == 200) {
      if (response.data['access_token'].toString().length > 1) {
        // 登录成功 执行逻辑
        //print('登录成功');
        _incrementCounter(response.data);
        return 'ok';
      } else {
        //print('用户名或者密码错误');
        return '用户名或者密码错误!'.tr;
      }
    } else {
      print(response.statusCode);
      //print('请求失败! 请稍后尝试!');
      return '请求失败! 请稍后尝试!'.tr;
    }
  }

// "token_type": "bearer",
//     "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJraW1zYW5nIG9ubGluZSBzaG9wIiwic2NvcGUiOlsiYWxsIl0sImF0aSI6IjA0YmRkYjBkLTIyYjUtNDUxYS1hNTMzLTAwZWY0NDVhZTVkMiIsImNsaWVudCI6IkN1c3RvbWVyLUFQUCIsImN1c3RvbWVyQ29kZSI6IkJDUEMxMDI3MzQiLCJleHAiOjE2MDgwMzcwMzAsImp0aSI6Ijg5YWU4NTQwLTg5MWQtNGE2YS1hNDQ4LTMyMDljNGJmN2UyOSIsImNsaWVudF9pZCI6IkN1c3RvbWVyLUFQUCJ9.I9r0N6tXaMN6wyo0P0EmOhje-fpIMbQplSzS1IuJYQw",
//     "expires_in": 604799,
//     "scope": "all",
//     "client": "Customer-APP",
//     "customerCode": "BCPC102734",
//     "jti": "04bddb0d-22b5-451a-a533-00ef445ae5d2"
  //请求服务器.
  _getLogin(data) async {
    BaseOptions options = BaseOptions(
      baseUrl: "http://api.ceccsl.com",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        'Authorization': 'Basic Q3VzdG9tZXItQVBQOkN1c3RvbWVyLUFQUC1zZWNyZXQ=',
        //'Content-Type': 'application/x-www-form-urlencoded',
      },
      validateStatus: (status) {
        //print(status);
        return true;
      },
    );

    Dio dio = Dio(options);
    // 强制SSL 证书检测 通过.
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
    var url = "/api/login/get?Name=${data.name}&Pwd=${data.password}";

    var response = await dio.get(url);
    if (response.statusCode == 200) {
      if (response.data != null) {
        _xie(response.data);
        return 'ok';
      }
    } else {
      return '请求失败请稍后尝试!'.tr;
    }
  }

  _xie(data) {
    SharedPreferences.getInstance().then(
      (sp) => {
        sp.setString('Name', data['Name']),
      },
    );
  }

  _incrementCounter(data) {
    SharedPreferences.getInstance().then((sp) => {
          sp.setString('access_token', data['access_token']),
          sp.setString('refresh_token', data['refresh_token']),
          sp.setString('customerCode', data['customerCode']),
        });
  }

  // _incrementCounter2(data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('access_token', data['access_token']);
  //   await prefs.setString('refresh_token', data['refresh_token']);
  //   await prefs.setString('customerCode', data['customerCode']);
  //   //prefs.getString('access_token') ??
  //   //int counter = (prefs.getInt('counter') ?? 0) + 1;
  //   //print('Pressed $counter times.');
  //   // await prefs.setInt('counter', counter);
  // }
}
