import 'dart:ui';
import 'app_barcode_scanner_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_barcode/ai_barcode.dart';

class CustomSizeScannerPage extends StatefulWidget {
  @override
  _CustomSizeScannerPageState createState() => _CustomSizeScannerPageState();
}

class _CustomSizeScannerPageState extends State<CustomSizeScannerPage> {
  ScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = ScannerController(scannerResult: (result) {
      // //关闭识别
      // _scannerController.stopCameraPreview();

      // //打开识别
      //_scannerController.startCameraPreview();
    });
  }

  bool openFlash = false;
  // ignore: non_constant_identifier_names
  Color openFlash_color = Colors.yellow;
  //String _code = '';

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //double screenWidth = ScreenUtil.getInstance().screenWidth;
    //print(size.width);

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan order number'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              //fit: StackFit.expand,
              children: <Widget>[
                AppBarcodeScannerWidget.defaultStyle(
                  resultCallback: (String code) {
                    if (openFlash == true) {
                      print('关闭');
                      _scannerController.closeFlash();
                      setState(() {
                        openFlash = false;
                        openFlash_color = Colors.yellow;
                      });
                    }
                    Get.offAllNamed('/HomePage', arguments: {'code': code});
                    // setState(() {
                    //   _code = code;
                    // });
                  },
                ),
                // Container(
                //   height: 170,
                //   width: 170,
                //   color: Colors.blue,
                // ),
                //开关手电筒
                // Positioned(
                //   left: MediaQuery.of(context).size.width / 2.2,
                //   //right: 10,
                //   //top: 10,
                //   bottom: MediaQuery.of(context).size.height / 8,
                //   child: Container(
                //     child: IconButton(
                //       icon: Icon(Icons.flash_on_outlined),
                //       iconSize: 30,
                //       color: openFlash_color,
                //       onPressed: () {
                //         if (openFlash == false) {
                //           _scannerController.openFlash();
                //           setState(() {
                //             openFlash = true;
                //             openFlash_color = Colors.white;
                //           });
                //         } else {
                //           _scannerController.closeFlash();
                //           setState(() {
                //             openFlash_color = Colors.yellow;
                //             openFlash = false;
                //           });
                //         }

                //         //
                //       },
                //     ),
                //   ),
                // )
              ],
            ),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(_code),
          //   ],
          // ),
        ],
      ),
    );
  }
}
