import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class LIU_ShowDialog extends StatelessWidget {
  const LIU_ShowDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('sssss');
    return Container(
      child: Text('ffffffffffffff'),
    );
  }

  // ignore: unused_element
  _showDialog(widgetContext) {
    print('object');
    showCupertinoDialog(
      context: widgetContext,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('确认删除'),
          actions: [
            CupertinoDialogAction(
              child: Text('确认'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('取消'),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
