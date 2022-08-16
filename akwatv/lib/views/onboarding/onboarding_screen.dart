import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _scrollController = new PageController();
  List<String> textTitle = [
    'Watch your favorite movies on any device',
    'Download and watch later',
    'Start a free 14 days trial'
  ];
  List<String> textSubTitle = [
    "You can now stream on your phonetablets,  TV and laptop without making an additional payment.",
    "You can now download unlimited videos and watch later",
    "Oh yes, you can watch unlimted videos with your free 14 days trial"
  ];

  List<String> onboardImages = [
    onBoardingIcon1,
    onBoardingIcon2,
    onBoardingIcon3,
  ];

  @override
  void initState() {
    super.initState();
  }

  int indexData = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: InkWell(
              onTap: () {
                PreferenceUtils.setString(key: 'onboarding', value: 'value');
                Get.to(() => const AuthScreen());
              },
              child: Text(
                'Skip',
                style: TextStyle(color: AppColors.white, fontSize: 20.sp),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          children: [
            const SizedBox(
              height: ySpace3 * 2,
            ),
            GestureDetector(
              onPanUpdate: (details) {
                // Swiping in right direction.
                if (details.delta.dx > 0) {}

                // Swiping in left direction.
                if (details.delta.dx < 0) {}
              },
              child: SizedBox(
                height: 500,
                child: PageView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: textTitle.length,
                    itemBuilder: (context, index) {
                      indexData = index;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: ySpace3 * 1,
                          ),
                          SizedBox(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              child: SvgImage(asset: onboardImages[index])),
                          const SizedBox(
                            height: ySpace2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: generalHorizontalPadding),
                            child: Text(
                              textTitle[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: ySpace1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              textSubTitle[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: indexData == 0 ? 8.h : 6.w,
                                  width: indexData == 0 ? 20.w : 6.w,
                                  decoration: BoxDecoration(
                                      color: indexData == 0
                                          ? AppColors.primary
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  height: indexData == 1 ? 8.h : 6.w,
                                  width: indexData == 1 ? 20.w : 6.w,
                                  decoration: BoxDecoration(
                                      color: indexData == 1
                                          ? AppColors.primary
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  height: indexData == 2 ? 8.h : 6.w,
                                  width: indexData == 2 ? 20.w : 6.w,
                                  decoration: BoxDecoration(
                                      color: indexData == 2
                                          ? AppColors.primary
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            const SizedBox(
              height: ySpace3 * 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        decrementQuizItem();
                      },
                      icon: const Icon(
                        Icons.west,
                        size: 16,
                        color: AppColors.white,
                      ),
                      label: const Text(
                        'Back',
                        style: TextStyle(color: AppColors.white),
                      )),
                  InkWell(
                    splashColor: AppColors.black,
                    onTap: () {
                      if (indexData == 2) {
                        PreferenceUtils.setString(
                            key: 'onboarding', value: 'value');

                        Get.to(() => const AuthScreen());
                      } else {
                        setState(() {
                          incrementQuizItem();
                        });
                      }
                    },
                    child: const SvgImage(
                        asset: onBoardingArrowIcon, height: 30, width: 30),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  incrementQuizItem() async {
    if (indexData == 0) {
      setState(() {
        _scrollController.nextPage(
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
        indexData = (indexData++) % textTitle.length;
      });
    } else if (indexData == 8) {
      setState(() {
        _scrollController.nextPage(
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
        indexData = (indexData + 1) % 0;
      });
    }
    {
      setState(() {
        _scrollController.nextPage(
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
        indexData = (indexData + 1) % textTitle.length;
      });
    }
  }

  decrementQuizItem() async {
    if (indexData == 0) {
      setState(() {
        _scrollController.previousPage(
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
        indexData = (indexData - 1) % 0;
      });
    } else {
      setState(() {
        _scrollController.previousPage(
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
        indexData = (indexData - 1) % textTitle.length;
      });
    }
  }
}
