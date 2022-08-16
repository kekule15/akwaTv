import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/views/onboarding/signup.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      stops: const [
                    0.1,
                    1.7
                  ],
                      colors: [
                    AppColors.black.withOpacity(0.3),
                    AppColors.black.withOpacity(0.7)
                  ])),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width,
                child: const ImageWidget(
                  asset: authImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [
                        0,
                        1
                      ],
                      colors: [
                        AppColors.black.withOpacity(0.0),
                        AppColors.black.withOpacity(0.9)
                      ]),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  stops: const [
                0.0,
                1.7
              ],
                  colors: [
                AppColors.black.withOpacity(0.7),
                AppColors.black.withOpacity(0.9)
              ])),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: generalHorizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const ImageWidget(asset: akwaTvLogo),
                 Text(
                  "letStart".tr,
                  style:const TextStyle(color: AppColors.white),
                ),
                const SizedBox(
                  height: ySpace3 * 3,
                ),
                CustomButton(
                  onclick: () {
                    Get.to(() => const SignUpPage());
                  },
                  borderColor: false,
                  title:  Text(
                    'register'.tr,
                    style:const TextStyle(color: AppColors.white),
                  ),
                  color: AppColors.primary,
                ),
                const SizedBox(
                  height: ySpace2,
                ),
                CustomButton(
                  onclick: () {
                    Get.to(() => const LoginPage());
                  },
                  borderColor: true,
                  title: const Text(
                    'Login',
                    style: TextStyle(color: AppColors.white),
                  ),
                  color: Colors.transparent,
                ),
                const SizedBox(
                  height: ySpace3 * 3,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
