import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = new PageController();
  List<String> textTitle = [
    'Watch your favorite movies on any device',
    'Download and watch later',
    'Start a free 7 days trial'
  ];
  List<String> textSubTitle = [
    "You can now stream on your phonetablets,  TV and laptop without making an additional payment.",
    "You can now download unlimited videos and watch later",
    "Oh yes, you can watch unlimted videos with your free seven days trial"
  ];

  List<String> onboardImages = [
    onBoardingIcon1,
    onBoardingIcon2,
    onBoardingIcon3,
  ];
  @override
  void initState() {
    GetStorage box = GetStorage();
    box.write('onboarding', 'value');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: PageView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: textTitle.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: ySpace3 * 3,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Skip',
                          style: TextStyle(
                              color: AppColors.white, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: ySpace3 * 2,
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
                          height: index == 0 ? 8.h : 6.w,
                          width: index == 0 ? 20.w : 6.w,
                          decoration: BoxDecoration(
                              color: index == 0
                                  ? AppColors.primary
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          height: index == 1 ? 8.h : 6.w,
                          width: index == 1 ? 20.w : 6.w,
                          decoration: BoxDecoration(
                              color: index == 1
                                  ? AppColors.primary
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          height: index == 2 ? 8.h : 6.w,
                          width: index == 2 ? 20.w : 6.w,
                          decoration: BoxDecoration(
                              color: index == 2
                                  ? AppColors.primary
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
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
                              controller.previousPage(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.ease);
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
                            setState(() {
                              controller.nextPage(
                                  duration: const Duration(microseconds: 200),
                                  curve: Curves.ease);
                            });
                          },
                          child: const SvgImage(
                              asset: onBoardingArrowIcon,
                              height: 30,
                              width: 30),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
