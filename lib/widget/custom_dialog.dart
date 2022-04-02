import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/commons/navigation.dart';

customDialog(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Coming Soon!!!'),
        content: Text('This feature will be coming soon!!!'),
        actions: [
          CupertinoDialogAction(
            child: Text('Ok!!!'),
            onPressed: () => Navigation.back(),
          ),
        ],
      ),
    );
  } else {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Coming Soon!!!'),
              content: Text('This feature will be coming soon!!!'),
              actions: [
                TextButton(
                  child: Text('Ok!!!'),
                  onPressed: () => Navigation.back(),
                ),
              ],
            ));
  }
}
