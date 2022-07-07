import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/home/home_view/video_details.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';

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

  BetterPlayerController? _betterPlayerController;
  @override
  void initState() {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
          //deviceOrientationsAfterFullScreen: const [DeviceOrientation.portraitUp],
          aspectRatio: 16 / 9,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableSkips: false,
            enableOverflowMenu: false,
          )),
      betterPlayerDataSource: betterPlayerDataSource,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _loginViewModel = ref.watch(viewModel);
    final _videoViewModel = ref.watch(videoViewModel);
    _loginViewModel.getProfile;
    _videoViewModel.getVideoList;
  }

  @override
  void dispose() {
    // _betterPlayerController!.dispose();
    super.dispose();
  }

  bool switchMode = false;

  @override
  Widget build(BuildContext context) {
    final _videoViewModel = ref.watch(videoViewModel);
    var videoData = _videoViewModel.listVideoData.data;
    //print(videoData!.length);
    // var firstVideo = videoData![0].video.
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawerPage(),
      body: _videoViewModel.listVideoData.data == null
          ? const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            )
          : SafeArea(
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: AppColors.termsTextColor))),
                          width: MediaQuery.of(context).size.width,
                          height: 320,
                          child: Column(
                            children: [
                              Container(
                                color: AppColors.white,
                                child: AspectRatio(
                                  aspectRatio: 18 / 10,
                                  child: BetterPlayer(
                                    controller: _betterPlayerController!,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  height: 85,
                                  //color: AppColors.primary,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        dense: true,
                                        minVerticalPadding: 0.0,
                                        visualDensity: const VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        contentPadding: EdgeInsets.all(0),
                                        title: Text(
                                          videoData!.data![0].title!,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${videoData.data![0].year!}  |",
                                                  style: const TextStyle(
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "${videoData.data![0].ageLimit.toString()}+",
                                                  style: const TextStyle(
                                                    color: AppColors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        trailing: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VideoDetailsPage(
                                                          title: videoData
                                                              .data![0].title!,
                                                          image: videoData
                                                              .data![0].img,
                                                        )));
                                          },
                                          child: const Icon(
                                            Icons.info,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                              // SizedBox(
                              //   height: 300,
                              //   width: MediaQuery.of(context).size.width,
                              //   child: const ImageWidget(
                              //     asset: wickedAccused1,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              // const Center(
                              //   child: CircularProgressIndicator(
                              //     color: AppColors.primary,
                              //   ),
                              // )
                            ],
                          )),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 350, 0, 10),
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          children: [
                            Text(
                              'Akwa Amaka Originals',
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 13.sp),
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
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
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
                                                                .movieList[
                                                                    index]
                                                                .movieName,
                                                            image: PlayModel
                                                                .movieList[
                                                                    index]
                                                                .movieImage,
                                                          )));

                                              //  Navigator.pop(context);
                                              // Get.to(() => AppVideo());
                                            },
                                            child: Container(
                                              height: 180,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.termsTextColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          PlayModel
                                                              .movieList[index]
                                                              .movieImage),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: ySpaceMin,
                                          ),
                                          Text(
                                            PlayModel
                                                .movieList[index].movieName,
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
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 13.sp),
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
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 180,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: AppColors.termsTextColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: AssetImage(PlayModel
                                                        .movieList[index]
                                                        .movieImage),
                                                    fit: BoxFit.cover)),
                                          ),
                                          const SizedBox(
                                            height: ySpaceMin,
                                          ),
                                          Text(
                                            PlayModel
                                                .movieList[index].movieName,
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
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
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
            ),
    );
  }
}
