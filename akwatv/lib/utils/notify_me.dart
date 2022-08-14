import 'dart:convert';

import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/app_helpers.dart';
import 'package:akwatv/utils/notification_fcm.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

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

  //Notification Sending Side Using Dio flutter Library to make http post request

  static Future<void> sendNotification(
      {required String sender, required String content}) async {
    var token = LocalStorageManager.fcmStorage.read('userToken');

    final data = {
      "to": token,
      "priority": "high",
      "notification": {"title": sender, "body": content, "sound": "default"},
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
    };

    final headers = {
      //'content-type': 'application/json',
      'Authorization': fcmServerKey
    };

    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );

    try {
      final response = await Dio(options)
          .post('https://fcm.googleapis.com/fcm/send', data: json.encode(data));

      if (response.statusCode == 200) {
        print(response.data);
        // Fluttertoast.showToast(msg: 'Request Sent');
      } else {
        print('notification sending failed');
        // on failure do sth
      }
    } catch (e) {
      print('exception $e');
    }
  }
}
