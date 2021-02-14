import 'package:CE.CCSL/utils/HttpData.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class HomePage extends StatefulWidget {
  final arguments;
  HomePage({Key key, this.arguments}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List listData = [];

  @override
  void initState() {
    if (Get.arguments != null) {
      __get(Get.arguments['code']);
    }
    _getCheData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 解决键盘 https://api.flutter.dev/flutter/material/Scaffold/resizeToAvoidBottomInset.html
      //resizeToAvoidBottomPadding: false,
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('CE.CCSL'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.login_outlined),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              //String name = prefs.setString('Name', null);
              prefs.setString('Name', null);
              Get.offNamed('/Login');
              print('退出登录');
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

// return MaterialButton(
//               onPressed: () => openMapsSheet(context),
//               child: Text('Show Maps'),
//             );
  _getCheData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('Name');
    //prefs.setString('Name', null);
    print('name');
    print(name);
    if (name == null) {
      Get.offNamed('/Login');
    }
    // int counter = (prefs.getInt('counter') ?? 0) + 1;
    // print('Pressed $counter times.');
    await prefs.setInt('N', 1);
  }

  _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSearchBarUI(),
        _huiyuan(),
      ],
    );
  }

  // _huiyuan2() {
  //   return Expanded(
  //     child: ListView.builder(
  //       //shrinkWrap: true,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Text('Item$index');
  //       },
  //       itemExtent: 20,
  //     ),
  //   );
  // }

  //shrinkWrap: true,
  _huiyuan() {
    if (this.listData == null) {
      return Expanded(
        child: Center(
          child: Text(''),
        ),
      );
    }
    print(this.listData);

    return Expanded(
      child: ListView(
        //physics: BouncingScrollPhysics(),
        children: this.listData.map<Widget>((v) {
          return Container(
            child: Container(
              //height: 400,
              padding: EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  semanticContainer: false,
                  elevation: 20.0, //阴影
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  //margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('客户名称:'.tr),
                            Text('${v['Contact']}'),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('客户电话:'.tr),
                            InkWell(
                              onTap: () {
                                _showDialog(
                                  context,
                                  title: 'prompt',
                                  centonts: 'dial number ${v['Phone']}',
                                  s1: v['Phone'],
                                );
                                //print(ss);
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Icon(
                                      Icons.phone_in_talk,
                                      color: Colors.blue,
                                      size: 14,
                                    ),
                                  ),
                                  Text('${v['Phone']}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('客户地址:'.tr),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (v['latitude'] == 0.0) {
                                    BotToast.showText(text: '客户无定位信息'.tr);
                                    return;
                                  }
                                  openMapsSheet(
                                    context,
                                    v['latitude'],
                                    v['longitude'],
                                  );
                                  //openMapsSheet(context, 11.5562167, 104.9097976);
                                },
                                child: Text(
                                  '${v['Province'] != null ? v['Province'] : ''} ${v['City'] != null ? v['City'] : ''} ${v['Add'] != null ? v['Add'] : ''}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('位置照片:'.tr),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    openDialog(context,
                                        '${v['Img1'] != '' ? v['Img1'] : 'https://ce-client-app.oss-ap-southeast-1.aliyuncs.com/images/null.png'}');
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      '${v['Img1'] != '' ? v['Img1'] : 'https://ce-client-app.oss-ap-southeast-1.aliyuncs.com/images/null.png'}',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                InkWell(
                                  onTap: () {
                                    openDialog(context,
                                        '${v['Img2'] != '' ? v['Img2'] : 'https://ce-client-app.oss-ap-southeast-1.aliyuncs.com/images/null.png'}');
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      '${v['Img2'] != '' ? v['Img2'] : 'https://ce-client-app.oss-ap-southeast-1.aliyuncs.com/images/null.png'}',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  //放大图片
  openDialog(BuildContext context, String img) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: Dialog(
            child: PhotoView(
              tightMode: true,
              imageProvider: NetworkImage(img),
              heroAttributes: const PhotoViewHeroAttributes(tag: ''),
            ),
          ),
        );
      },
    );
  }

  //打开地图
  openMapsSheet(context, lat, lon) async {
    try {
      final coords = Coords(lat, lon);
      final title = 'Ocean Beach';
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  __get(String code) {
    // 012355426
    if (code.length == 5) {
      code = 'CE' + code;
    }
    if (code.length == 11) {
      code = 'C' + code;
    }
    String url = '/api/address/getaddress?num=$code';
    //showAchievementView(context);
    print(url);
    GetHttpUrl(url: url, status: 7777).then((value) {
      print(value);
      if (value == null) {
        return;
      }
      if (value['status'] == 'Error') {
        BotToast.showText(text: '未查询到地址信息'.tr);
        return;
      }

      setState(() {
        listData = value['address']; // 轨迹信息给listData
      });
    });
  }

  var _code = '运单编号/会员编号'.tr;
//搜索框
  //定义一个controller
  TextEditingController _unameController = TextEditingController();
  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Material(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF90CAF9),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    onTap: () {
                      //关闭键盘
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (listData.isEmpty) {
                        Get.toNamed('/SaoMa');
                      } else {
                        Get.toNamed('/SaoMa');
                        //Get.offNamed('/saoma');
                      }

                      /// 延时2s执行返回
                      // Future.delayed(Duration(seconds: 0.5), () {
                      //   Get.toNamed('/saoma');
                      // });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.qr_code_scanner),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 6, bottom: 6),
                  child: Container(
                    height: 45,
                    //width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 5, top: 1, bottom: 1),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        controller: _unameController,
                        onChanged: (String txt) {},
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 14),
                          //isDense: true,
                          border: InputBorder.none,
                          hintText: _code, //默认值
                          // prefix: Expanded(
                          //   child: Text('CE'),
                          // ),
                          prefixText: 'CE ',
                          //labelText: 'CE',
                          // prefixIcon: Center(

                          //   child: Text('CE'),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4DDAC4),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    onTap: () {
                      //Get.toNamed('/saoma');
                      //print(_unameController.text);
                      __get(_unameController.text); //搜索 按钮点击事件.
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //提示框
  _showDialog(widgetContext,
      {String title = '提示', String centonts = '内容', String s1 = ''}) {
    showCupertinoDialog(
      context: widgetContext,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('$title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('$centonts'),
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: () {
                //确认后执行逻辑..
                //拨打号码
                _makePhoneCall('tel:$s1');

                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('No'),
              isDestructiveAction: false,
              onPressed: () {
                //取消后执行逻辑..
                print('取消');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // URL 启动设备功能
  Future _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
