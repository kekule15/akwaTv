import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/video_box_widget.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  Datum videoData;

  VideoDetailsPage({Key? key, required this.videoData}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  BetterPlayerController? _betterPlayerController;
  List<Datum> similarVideoData = [];
  String url = '';
  String description = '';
  String mtitle = '';
  @override
  void didChangeDependencies() {
    // var videoData = ModalRoute.of(context)?.settings.arguments as Datum;
    setState(() {
      url = widget.videoData.video!;
      description = widget.videoData.desc!;
      mtitle = widget.videoData.title!;
    });
    initPlayer(link: url);

    sortSimilarVideos();

    super.didChangeDependencies();
  }

  void initPlayer({required dynamic link}) async {
    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, link);
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
          autoPlay: true,
          //deviceOrientationsAfterFullScreen: const [DeviceOrientation.portraitUp],
          aspectRatio: 16 / 9,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableSkips: true,
            enableOverflowMenu: true,
            progressBarPlayedColor: AppColors.primary,
          )),
      betterPlayerDataSource: betterPlayerDataSource,
    );

    /// initialise player
  }

  void disposePlayer() {
    _betterPlayerController!.dispose();

    /// dispose player
  }

  void resetPlayer(
      {required dynamic videoLink,
      required String title,
      required String desc}) {
    disposePlayer();
    initPlayer(link: videoLink);
    setState(() {
      mtitle = title;
      description = desc;
      url = videoLink;
    });
  }

  @override
  void dispose() {
    _betterPlayerController!.dispose();
    super.dispose();
  }

  sortSimilarVideos() async {
    final _videoViewModel = ref.watch(videoViewModel);
    var similarVideos = _videoViewModel.listVideoData.data;
    for (var element in similarVideos!.data!) {
      if (element.genre == widget.videoData.genre) {
        similarVideoData.add(element);
      }
    }
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
        body: widget.videoData == null
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView(
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
                          mtitle,
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
                            description,
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
                          'SIMILAR MOVIES #${videoData.genre}',
                          style: TextStyle(
                              color: AppColors.white, fontSize: 13.sp),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        similarVideoData.isEmpty
                            ? const Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : SizedBox(
                                height: 240,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: similarVideoData.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 0),
                                          child: HorizontalVideoBoxWidget(
                                              ontap: () {
                                                resetPlayer(
                                                  videoLink:
                                                      similarVideoData[index]
                                                          .video!,
                                                  title: similarVideoData[index]
                                                      .title!,
                                                  desc: similarVideoData[index]
                                                      .desc!,
                                                );
                                              },
                                              img: similarVideoData[index].img!,
                                              title: similarVideoData[index]
                                                  .title!));
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
