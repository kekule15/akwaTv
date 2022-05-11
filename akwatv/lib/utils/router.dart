// ignore_for_file: prefer_const_constructors

import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/views/home/navigation_page.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/congratulation_page.dart';
import 'package:akwatv/views/onboarding/onboarding_screen.dart';
import 'package:akwatv/widgets/custom_button.dart';

import 'package:flutter/foundation.dart';

abstract class Routes {
  static const homeNavigation = "/homeNavigation";
  static const onboardingScreen = "/onboardingScreen";
  static const congratulationsScreeen = "/congratulationsScreeen";
  static const authScreen = "/authScreen";



}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  var args = settings.arguments;
  
  switch (settings.name) {
    case Routes.homeNavigation:
      return MaterialPageRoute<dynamic>(
          builder: (context) => const HomeNavigation(), settings: settings);
    case Routes.onboardingScreen:
      return MaterialPageRoute<dynamic>(
          builder: (context) => const OnboardingScreen(), settings: settings);
    case Routes.congratulationsScreeen:
      return MaterialPageRoute<dynamic>(
          builder: (context) => const CongratulationScreen(), settings: settings);
    case Routes.authScreen:
      return MaterialPageRoute<dynamic>(
          builder: (context) => const AuthScreen(), settings: settings);


    default:
      return unknownRoutePage(settings.name!);
  }
}

PageRoute unknownRoutePage(String routeName) => MaterialPageRoute(
      builder: (ctx) => Scaffold(
        body: Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: generalHorizontalPadding, vertical: ySpace2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const ImageWidget(asset: ''),
              const SizedBox(height: ySpace2 - 4),
              Text('Oops,\n\nLooks like this page is in development',
                  textAlign: TextAlign.center,
                  style: Theme.of(ctx)
                      .primaryTextTheme
                      .headline3
                      ?.copyWith(color: AppColors.pureBlack)),
              const SizedBox(height: ySpace3 + ySpace1 - 5),
              if (kDebugMode)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Text(
                    routeName == "/"
                        ? 'Initial route not found! \n did you forget to annotate your home page with @initial or @MaterialRoute(initial:true)?'
                        : 'Route name $routeName is not found!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              CustomButton(
                onclick: () => Navigator.of(ctx).pop(),
                title: Text('Go back'),
                borderColor: null,
                color: AppColors.primary,
              )
            ],
          ),
        ),
      ),
    );
