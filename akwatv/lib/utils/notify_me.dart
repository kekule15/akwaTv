import 'package:akwatv/styles/appColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotifyMe {
  static showAlert(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primary,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
