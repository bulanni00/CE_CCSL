// import 'package:CE/utils/Loader.dart';
// import 'package:flutter/material.dart';
// import 'package:achievement_view/achievement_view.dart';

// //* 利用overlay实现Toast

// // 加载等待......
// class Toast {
//   static void showAchievementView(BuildContext context, title, centont) {
//     AchievementView(context,
//         title: title,
//         subTitle: centont,
//         alignment: Alignment(0, 0.5),
//         //onTab: _onTabAchievement,
//         //icon: Icon(Icons.insert_emoticon, color: Colors.white,),
//         //typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
//         borderRadius: 8.0,
//         //color: Colors.blueGrey,
//         //textStyleTitle: TextStyle(),
//         //textStyleSubTitle: TextStyle(),
//         //alignment: Alignment.topCenter,
//         //duration: Duration(seconds: 3),
//         //isCircle: false,
//         listener: (status) {
//       //print(status);
//       //AchievementState.opening;
//       //AchievementState.open
//       //AchievementState.closing
//       //AchievementState.closed
//     })
//       ..show();
//   }

//   static void showWait(
//       {@required BuildContext context,
//       @required String message,
//       @required double height}) {
//     //print(MediaQuery.of(context).padding.top);

//     //创建一个OverlayEntry对象
//     OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
//       //外层使用Positioned进行定位，控制在Overlay中的位置
//       return new Positioned(
//           // 定位子widget //MediaQuery.of(context).size.height * 0.1 // MediaQueryData.fromWindow(window).padding.top
//           top: height,
//           //top: MediaQueryData.fromWindow(window).padding.top,
//           child: new Material(
//             color: Colors.white.withOpacity(.5),
//             child: new Container(
//               //color: Colors.blue.withOpacity(0.0),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               alignment: Alignment.center,
//               child: new Center(child: Liu_Loader()),
//             ),
//           ));
//     });
//     //往Overlay中插入插入OverlayEntry
//     Overlay.of(context).insert(overlayEntry);
//     //两秒后，移除Toast
//     new Future.delayed(Duration(seconds: 2)).then((value) {
//       overlayEntry.remove();
//     });
//   }

//   static void all({@required BuildContext context, @required String message}) {
//     //创建一个OverlayEntry对象
//     OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
//       //外层使用Positioned进行定位，控制在Overlay中的位置
//       return new Positioned(
//           top: MediaQuery.of(context).size.height * 0.7,
//           child: new Material(
//             color: Colors.red.withOpacity(.1),
//             child: new Container(
//               //color: Colors.blue.withOpacity(0.0),
//               width: MediaQuery.of(context).size.width,
//               height: 1600,
//               alignment: Alignment.center,
//               child: new Center(
//                 child: new Card(
//                   child: new Padding(
//                     padding: EdgeInsets.all(8),
//                     child: new Text(message),
//                   ),
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           ));
//     });
//     //往Overlay中插入插入OverlayEntry
//     Overlay.of(context).insert(overlayEntry);
//     //两秒后，移除Toast
//     new Future.delayed(Duration(seconds: 2)).then((value) {
//       overlayEntry.remove();
//     });
//   }
// }
