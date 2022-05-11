import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/forgot_password/otp_verification_page.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  const VideoDetailsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        //automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            height: 200.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(gettoPreview), fit: BoxFit.fill)),
          ),
          const SizedBox(
            height: ySpace1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: generalHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Omo Gheto',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      '2021',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w200),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '18+',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w200),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '2h 3m',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w200),
                    ),
                      const SizedBox(
                      width: 5,
                    ),
                  
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
