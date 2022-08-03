import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class DownLoadsPage extends ConsumerStatefulWidget {
  const DownLoadsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DownLoadsPageState();
}

class _DownLoadsPageState extends ConsumerState<DownLoadsPage> {
  final searchController = TextEditingController();
  BetterPlayerController? _betterPlayerController;
  ChewieController? chewieController;

  @override
  void didChangeDependencies() {
    // initPlayer();
    final videoPlayerController = VideoPlayerController.network(
        'https://d31igjfr1qqzjn.cloudfront.net/HLS57/OGBANJE.m3u8');

    videoPlayerController.initialize();

    chewieController = ChewieController(
        aspectRatio: 16 / 9,
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
        allowPlaybackSpeedChanging: false);
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   controller = CachedVideoPlayerController.network(
  //       "https://d31igjfr1qqzjn.cloudfront.net/HLS57/OGBANJE.m3u8",
  //       videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false));
  //   controller!.initialize().then((_) {
  //     setState(() {});
  //     controller!.pause();
  //   });

  //   super.initState();
  // }

  @override
  void dispose() {
    chewieController!.pause();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'My Downloads',
          style: TextStyle(color: AppColors.white, fontSize: 16.sp),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: Chewie(
                controller: chewieController!,
              )),
        ],
      ),
    );
  }
}
