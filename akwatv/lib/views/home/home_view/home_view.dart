import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/home/home_view/video_details.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openMyDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  VideoPlayerController? _videoPlayerController1;

  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    _chewieController?.enterFullScreen();
  }

  @override
  void dispose() {
    _videoPlayerController1!.dispose();

    _chewieController?.dispose();
    super.dispose();
  }

  List<String> srcs = [
    "https://d3dqcuvicxfd5x.cloudfront.net/DEEPER%20THAN%20OCEAN.mp4",
    "https://d3dqcuvicxfd5x.cloudfront.net/DEEPER%20THAN%20OCEAN.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
  ];
  // String url =
  //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(srcs[currPlayIndex]);

    await Future.wait([_videoPlayerController1!.initialize()]);
    _createChewieController();
    _videoPlayerController1!.addListener(() async {
      if (_videoPlayerController1!.value.position ==
          _videoPlayerController1!.value.duration) {
        await Future.delayed(Duration(seconds: 2), () async {
          print('Video Stopped');
          setState(() {
            currPlayIndex = (currPlayIndex + 1) % srcs.length;
          });
          await initializePlayer();
        });
      }
    });

    setState(() {});
  }

  void _createChewieController() async {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1!,
      autoPlay: false,
      looping: false,
      //aspectRatio: 3 / 3,
      //showControls: false,
      materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primary,
          handleColor: AppColors.primary,
          backgroundColor: Colors.grey,
          bufferedColor: AppColors.white),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
  }

  int currPlayIndex = 0;

//play next video
  Future<void> playNextVideo() async {
    await _videoPlayerController1!.pause();
    setState(() {
      currPlayIndex = (currPlayIndex + 1) % srcs.length;
    });
    await initializePlayer();
  }

//play previous video
  Future<void> playPreviousVideo() async {
    await _videoPlayerController1!.pause();
    setState(() {
      currPlayIndex = (currPlayIndex - 1) % srcs.length;
    });
    await initializePlayer();
  }

  bool switchMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawerPage(),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: AppColors.termsTextColor))),
                  width: MediaQuery.of(context).size.width,
                  height: 300.w,
                  child: _chewieController != null &&
                          _chewieController!
                              .videoPlayerController.value.isInitialized
                      ? SizedBox(
                          height: 300,
                          child: Chewie(
                            controller: _chewieController!,
                          ),
                        )
                      : Stack(
                          children: [
                            SizedBox(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: const ImageWidget(
                                asset: wickedAccused1,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          ],
                        )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 330, 0, 10),
                child: ListView(
                  children: [
                    Text(
                      'Akwa Amaka Originals',
                      style: TextStyle(color: AppColors.white, fontSize: 13.sp),
                    ),
                    const Divider(
                      color: AppColors.white,
                    ),
                    const SizedBox(
                      height: ySpace3,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: PlayModel.movieList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoDetailsPage(
                                                    title: PlayModel
                                                        .movieList[index]
                                                        .movieName,
                                                    image: PlayModel
                                                        .movieList[index]
                                                        .movieImage,
                                                  )));

                                      //  Navigator.pop(context);
                                      // Get.to(() => AppVideo());
                                    },
                                    child: Container(
                                      height: 180,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: AppColors.termsTextColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                        color: AppColors.white,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Text(
                      'Top Of The Week',
                      style: TextStyle(color: AppColors.white, fontSize: 13.sp),
                    ),
                    const Divider(
                      color: AppColors.white,
                    ),
                    const SizedBox(
                      height: ySpace3,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: PlayModel.movieList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Container(
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
                                  const SizedBox(
                                    height: ySpaceMin,
                                  ),
                                  Text(
                                    PlayModel.movieList[index].movieName,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              )

              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Wicked Accused',
              //             style: TextStyle(
              //                 color: AppColors.white,
              //                 fontSize: 14.sp,
              //                 fontWeight: FontWeight.w600),
              //           ),
              //           Text(
              //             '2022 | 13+ | 2h23m',
              //             style: TextStyle(
              //                 color: AppColors.white, fontSize: 11.sp),
              //           ),
              //         ],
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             '4.6',
              //             style: TextStyle(
              //                 color: AppColors.white, fontSize: 11.sp),
              //           ),
              //           Text(
              //             '',
              //             style:
              //                 TextStyle(color: AppColors.white, fontSize: 9.sp),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: AppColors.white,
                    size: 25.w,
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
