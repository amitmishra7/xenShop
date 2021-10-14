import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SnackBarUtil {
  SnackBarUtil._privateConstructor();

  static final SnackBarUtil _instance = SnackBarUtil._privateConstructor();

  static SnackBarUtil get instance {
    return _instance;
  }

  static showToast(BuildContext context, String msg, {int duration}) {
    Toast.show(
      msg,
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.CENTER,
    );
  }
}
