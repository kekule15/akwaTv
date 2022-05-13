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
  final String? title;
  final String? image;

  const VideoDetailsPage({required this.title, required this.image});

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(0),
        children: [
          Container(
            height: 160.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.image!), fit: BoxFit.fill)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: generalHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title!,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold),
                ),
                // Row(
                //   children: [
                //     Text(
                //       '2021',
                //       style: TextStyle(
                //           color: AppColors.white,
                //           fontSize: 13.sp,
                //           fontWeight: FontWeight.w200),
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     Text(
                //       '18+',
                //       style: TextStyle(
                //           color: AppColors.white,
                //           fontSize: 13.sp,
                //           fontWeight: FontWeight.w200),
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     Text(
                //       '2h 3m',
                //       style: TextStyle(
                //           color: AppColors.white,
                //           fontSize: 13.sp,
                //           fontWeight: FontWeight.w200),
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //   ],
                // ),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      child: CustomButton(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.play_arrow,
                                color: AppColors.white,
                                size: 15,
                              ),
                              Text(
                                'Play',
                                style: TextStyle(color: AppColors.white),
                              )
                            ],
                          ),
                          onclick: () {},
                          color: AppColors.primary,
                          borderColor: false),
                    ),
                    SizedBox(
                      width: 150,
                      child: CustomButton(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.file_download,
                                color: AppColors.white,
                                size: 15,
                              ),
                              Text(
                                'Download',
                                style: TextStyle(color: AppColors.white),
                              )
                            ],
                          ),
                          onclick: () {},
                          color: Colors.transparent,
                          borderColor: true),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse pulvinar cras fermentum et. Eu, dictumst mauris est, etiam. ',
                    style: TextStyle(
                        color: AppColors.white.withOpacity(0.8), fontSize: 12),
                  ),
                ),
                // ListTile(
                //   contentPadding: const EdgeInsets.all(0),
                //   minLeadingWidth: 0,
                //   horizontalTitleGap: 5,
                //   leading: Padding(
                //     padding: const EdgeInsets.only(bottom: 16),
                //     child: Text(
                //       'Staring:',
                //       style: TextStyle(
                //           color: AppColors.white.withOpacity(0.8),
                //           fontSize: 13),
                //     ),
                //   ),
                //   title: Text(
                //     'Funke Akindele, Zubby Michael, Chioma Akpotha, Mercy Aigbe',
                //     style: TextStyle(
                //         color: AppColors.white.withOpacity(0.5), fontSize: 12),
                //   ),
                // ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: const [
                          Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 20,
                          ),
                          Text(
                            'Add To List',
                            style:
                                TextStyle(color: AppColors.white, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: const [
                          Icon(
                            Icons.thumb_up,
                            color: AppColors.white,
                            size: 20,
                          ),
                          Text(
                            'Rate',
                            style:
                                TextStyle(color: AppColors.white, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: const [
                          Icon(
                            Icons.share,
                            color: AppColors.white,
                            size: 20,
                          ),
                          Text(
                            'Share',
                            style:
                                TextStyle(color: AppColors.white, fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: AppColors.gray,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: generalHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SIMILAR MOVIES',
                  style: TextStyle(color: AppColors.white, fontSize: 13.sp),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: PlayModel.movieList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 0, right: 10),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => VideoDetailsPage(
                                        title: PlayModel
                                            .movieList[index].movieName,
                                        image: PlayModel
                                            .movieList[index].movieImage,
                                      ));
                                },
                                child: Container(
                                  height: 180,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: AppColors.termsTextColor,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: AssetImage(PlayModel
                                              .movieList[index].movieImage),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              const SizedBox(
                                height: ySpaceMin,
                              ),
                              Text(
                                PlayModel.movieList[index].movieName,
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
