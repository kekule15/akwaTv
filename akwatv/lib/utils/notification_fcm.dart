import 'dart:convert';

import 'package:akwatv/views/onboarding/signin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/subjects.dart';

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  //navigatorKey.currentState!.pushReplacementNamed(HOME_PAGE, arguments: 3);
}

/// Create a [AndroidNotificationChannel] for heads up notifications

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

GetStorage fcmStorage = GetStorage();

class PushNotificationsManager extends ConsumerState {
  @override
  final BuildContext context;
  PushNotificationsManager({
    required this.context,
  });

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    //print('setup notification');

    await FirebaseMessaging.instance.getToken().then((value) async {
      fcmStorage.write('userToken', value);

      print('Augustus fcm token $value');
      // send and update device fcm token to backend
      await ref.watch(viewModel).updateDeviceTokenService(deviceToken: value);
      //print('printed it');
    });

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
      enableLights: true,
      enableVibration: true,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification notification = message.notification!;
        AndroidNotification android = message.notification!.android!;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'ic_launcher',
                playSound: true,
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
          );
        } else {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              iOS: IOSNotificationDetails(
                presentSound: true,
                subtitle: "",
              ),
            ),
          );
        }
      },
    );

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    // manage when user opens application by clicking notifications
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      print("getting initial");
      // navigatorKey.currentState!.pushReplacementNamed(HOME_PAGE, arguments: 3);
    }

    // manage notification from notification while the app is minimized
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // navigatorKey.currentState!.pushReplacementNamed(HOME_PAGE, arguments: 3);
    });

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      //print('User granted provisional permission');
    } else {
      //print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
