import 'package:CE.CCSL/utils/HttpData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List dataList = [];

  @override
  void initState() {
    _getVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通知'.tr),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (this.dataList == null) {
      return Center(
        child: Text('数据加载中..'.tr),
      );
    } else {
      return _lists();
    }
  }

  Widget _lists() {
    return ListView.builder(
      itemCount: this.dataList.length,
      //shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          height: 115.0,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/News/detail',
                        arguments: {'id': this.dataList[index]['id']});
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(2),
                              child: Text(
                                '${this.dataList[index]["title"]}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xff111111),
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        height: 85.0,
                        width: 115.0,
                        margin: EdgeInsets.only(top: 3.0),
                        // child: Image.network(
                        //   '${this.dataList[index]["img"]}',
                        //   fit: BoxFit.cover,
                        // ),
                        decoration: BoxDecoration(
                            //color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${this.dataList[index]["img"] == '' ? 'https://ce-client-app.oss-ap-southeast-1.aliyuncs.com/images/null.png' : this.dataList[index]["img"]}',
                                //fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                            )
                            // image: DecorationImage(
                            //   image: AssetImage('assets/images/2.jpg'),
                            //   fit: BoxFit.cover,
                            // ),
                            ),
                      )
                    ],
                  ),
                ),
              ),
              // 分割线
              Container(
                margin: EdgeInsets.only(top: 4.0),
                color: Color(0xffeaeaea),
                constraints: BoxConstraints.expand(height: 4.0),
              )
            ],
          ),
        );
      },
    );
  }

  //请求服务器.
  _getVersion() {
    var url =
        "https://ce-client-app.oss-ap-southeast-1.aliyuncs.com/CCSL/news/news.json";
    GetHttpUrl(url: url, status: 7777).then((value) {
      //_getAppInfo(value);
      print(value['data']);
      setState(() {
        this.dataList = value['data'];
      });
    }).catchError((err) {
      print('err:$err');
    });
  }
}
