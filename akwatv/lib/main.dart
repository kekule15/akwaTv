import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/views/onboarding/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
        designSize: const Size(360, 700),
        builder: () => GetMaterialApp(
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
