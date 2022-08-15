import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/app_helpers.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/home/navigation_page.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/views/routes_args/congratulations_args.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class CongratulationScreen extends ConsumerWidget {
  const CongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _loginViewModel = ref.watch(viewModel);
    final _videoViewModel = ref.watch(videoViewModel);
    // final movieViewModel = ref.watch(movieController);
    var data =
        ModalRoute.of(context)?.settings.arguments as CongratulationsArgs;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Congratulaions!',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              data.name,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.white, fontSize: 17.sp),
            ),
            const SizedBox(
              height: ySpace3,
            ),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.white, fontSize: 15.sp),
            ),
            const SizedBox(
              height: ySpace1,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${data.subtitle} ",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: AppColors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: data.payLater == true
                        ? ''
                        : formatter.format(data.date!),
                    style: const TextStyle(
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
    );
  }
}
