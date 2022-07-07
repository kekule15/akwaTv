import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/home/navigation_page.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CongratulationScreen extends ConsumerStatefulWidget {
  const CongratulationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CongratulationScreenState();
}

class _CongratulationScreenState extends ConsumerState<CongratulationScreen> {
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final _loginViewModel = ref.watch(viewModel);
    final _videoViewModel = ref.watch(videoViewModel);
    final movieViewModel = ref.watch(movieController);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: ySpace3,
          ),
          Text(
            'Congratulaions!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
          const SizedBox(
            height: ySpaceMin,
          ),
          Text(
            box.read('username'),
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.white, fontSize: 17.sp),
          ),
          const SizedBox(
            height: ySpaceMin,
          ),
          Text(
            'Your free trial begins now!',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.white, fontSize: 15.sp),
          ),
          const SizedBox(
            height: ySpaceMin,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text: 'Your plan will renew on ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: AppColors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'May 23, 2022',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: ySpace3 * 3,
          ),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: const SvgImage(asset: congratulationIcon),
          ),
          const SizedBox(
            height: ySpace3 * 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: generalHorizontalPadding),
            child: CustomButton(
              borderColor: false,
              color: AppColors.primary,
              onclick: () {
                _videoViewModel.getVideoList();
                //  movieViewModel.setMovieUrl( 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');
                Get.offAll(() => const HomeNavigation());
              },
              title: Text(
                'Continue',
                style: TextStyle(color: AppColors.white, fontSize: 16.sp),
              ),
            ),
          ),
          const SizedBox(
            height: ySpace3,
          ),
        ],
      ),
    );
  }
}
