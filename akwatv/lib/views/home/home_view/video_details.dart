import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/forgot_password/otp_verification_page.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:better_player/better_player.dart';
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
  BetterPlayerController? _betterPlayerController;
  @override
  void didChangeDependencies() {
    var videoData = ModalRoute.of(context)?.settings.arguments as Datum;
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, videoData.video!);
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
          autoPlay: true,
          //deviceOrientationsAfterFullScreen: const [DeviceOrientation.portraitUp],
          aspectRatio: 16 / 9,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableSkips: true,
            enableOverflowMenu: true,
          )),
      betterPlayerDataSource: betterPlayerDataSource,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _betterPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   final _videoViewModel = ref.watch(videoViewModel);
    var videoList = _videoViewModel.listVideoData.data;
    var videoData = ModalRoute.of(context)?.settings.arguments as Datum;
    Future<bool> _onBackPressed() {
      return Future.delayed(const Duration(seconds: 1), () {
        _betterPlayerController!.dispose();
        Get.back();

        return false;
      });
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0),
          children: [
            Container(
              height: 300,
              //color: AppColors.white,
              child: BetterPlayer(
                controller: _betterPlayerController!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: generalHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoData.title!,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      videoData.desc!,
                      style: TextStyle(
                          color: AppColors.white.withOpacity(0.8),
                          fontSize: 12),
                    ),
                  ),
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
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 12),
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
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 12),
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
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 12),
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
                              Icons.file_download,
                              color: AppColors.white,
                              size: 20,
                            ),
                            Text(
                              'Download',
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 12),
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
                                    // Get.to(() => VideoDetailsPage(
                                    //       title: PlayModel
                                    //           .movieList[index].movieName,
                                    //       image: PlayModel
                                    //           .movieList[index].movieImage,
                                    //     ));
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
      ),
    );
  }
}
