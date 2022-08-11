import 'package:akwatv/firebase_options.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/notification_fcm.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/views/onboarding/splash.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_information/device_information.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  @override
  void initState() {
    setUpNotification();

    getDeviceId();
    super.initState();
  }

  GetStorage fcmStorage = GetStorage();
  GetStorage devicePlatformInfo = GetStorage();

  setUpNotification() async {
    await PushNotificationsManager(
      context: context,
    ).init();
   
  }

//QP1A.190711.020
  getDeviceId() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devicePlatformInfo.write('deviceId', androidInfo.id);

      // print('Running on ${androidInfo.id}'); // e.g. "Moto G (4)"
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devicePlatformInfo.write('deviceId', iosInfo.identifierForVendor);
      // print('Running on ${iosInfo.identifierForVendor}'); // e.g. "iPod7,1"

    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 700),
        builder: (widget, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Akwa Tv',
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.black,
                primaryColor: AppColors.primary,
                fontFamily: 'Sarabun',
                primarySwatch: Colors.blue,
              ),
              home: const SplashView(),
            ));
  }
}
