import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComingSoonCard extends ConsumerWidget {
  final String? title;
  final Widget? playButton;

  ComingSoonCard({required this.title, required this.playButton});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: AppColors.black,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ImageWidget(
                  asset: gettoPreview,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  right: 0, left: 0, top: 70, bottom: 70, child: playButton!)
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: generalHorizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title!,
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        )),
                    Row(
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: AppColors.white,
                              size: 13.w,
                            ),
                            Text('Set Reminder',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 9.sp,
                                )),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.info,
                              color: AppColors.white,
                              size: 13.w,
                            ),
                            Text('Info',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 9.sp,
                                )),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text('Coming May 25',
                    style: TextStyle(
                      color: AppColors.gray,
                      fontSize: 11.sp,
                    )),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse pulvinar cras fermentum et. Eu, dictumst mauris est, etiam. ',
                      style: TextStyle(
                        color: AppColors.gray,
                        fontSize: 11.sp,
                      )),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Staring:',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            ' Funke Akindele, Zubby Michael, Chioma Akpotha, Mercy Aigbe',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.gray,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
