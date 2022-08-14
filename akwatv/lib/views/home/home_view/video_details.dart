import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/notify_me.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/like_button.dart';
import 'package:akwatv/widgets/video_box_widget.dart';
import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  Datum videoData;

  VideoDetailsPage({Key? key, required this.videoData}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
 
  // BetterPlayerController? _betterPlayerController;
  ChewieController? chewieController;

  List<Datum> similarVideoData = [];
  String url = '';
  String description = '';
  String mtitle = '';
  dynamic movieID = '';
  bool enableFullScreen = false;
  @override
  void didChangeDependencies() {
    // var videoData = ModalRoute.of(context)?.settings.arguments as Datum;
    setState(() {
      url = widget.videoData.video!;
      description = widget.videoData.desc!;
      mtitle = widget.videoData.title!;
      movieID = widget.videoData.id;
    });
    initPlayer(link: url);

    sortSimilarVideos();
    sortRatedVideos();

    super.didChangeDependencies();
  }

  void initPlayer({required dynamic link}) async {
    print("my link $link");
    final videoPlayerController = VideoPlayerController.network(link);

    videoPlayerController.initialize();

    chewieController = ChewieController(
        aspectRatio: 16 / 9,
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
        allowFullScreen: false,
        allowPlaybackSpeedChanging: false);
  }

  void disposePlayer() {
    chewieController!.dispose();
    chewieController!.pause();

    /// dispose player
  }

  void resetPlayer(
      {required dynamic videoLink,
      required String title,
      required String desc,
      required String id}) {
    disposePlayer();
    initPlayer(link: videoLink);
    setState(() {
      mtitle = title;
      description = desc;
      url = videoLink;
      movieID = id;
    });
  }

  @override
  void dispose() {
    chewieController!.dispose();
    chewieController!.pause();
    super.dispose();
  }

  //sort video list to get similar videos
  sortSimilarVideos() async {
    final _videoViewModel = ref.watch(videoViewModel);
    var similarVideos = _videoViewModel.listVideoData.data;
    for (var element in similarVideos!.data!) {
      if (element.genre == widget.videoData.genre) {
        similarVideoData.add(element);
      }
    }
  }

  List<String> ratedListVideos = [];
  // sort rated videos
  sortRatedVideos() async {
    final loginViewModel = ref.watch(viewModel);
    var ratedList = loginViewModel.userProfileData.data;

    for (var element in ratedList!.data!.ratedList!) {
      ratedListVideos.add(element);
      checkRatedVideo();
    }
  }

  bool likeStatus = false;
  checkRatedVideo() async {
    if (ratedListVideos.contains(movieID)) {
      setState(() {
        likeStatus = true;
      });
    } else {
      setState(() {
        likeStatus = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _videoViewModel = ref.watch(videoViewModel);
    // final loginViewModel = ref.watch(viewModel);
    var videoList = _videoViewModel.listVideoData.data;
    var videoData = ModalRoute.of(context)?.settings.arguments as Datum;
    Future<bool> _onBackPressed() {
      return Future.delayed(const Duration(milliseconds: 1000), () {
        chewieController!.pause();
        chewieController!.dispose();

        Navigator.pop(context);

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
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Chewie(
                        controller: chewieController!,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: generalHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
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
                              onTap: () {
                                _videoViewModel.addToWatchListService(
                                    movieID: movieID);
                              },
                              child: Column(
                                children: [
                                  _videoViewModel.addTOListBTN
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.add,
                                          color: AppColors.white,
                                          size: 20,
                                        ),
                                  const Text(
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
                            Column(
                              children: [
                                LikeButton(
                                  onTap: () {
                                    if (ratedListVideos.contains(movieID)) {
                                      ratedListVideos.remove(movieID);
                                      setState(() {
                                        likeStatus = false;
                                      });
                                    } else {
                                      ratedListVideos.add(movieID);
                                      setState(() {
                                        likeStatus = true;
                                      });
                                    }
                                    _videoViewModel.likeVideoButton(
                                        movieID: movieID);
                                  },
                                  isLiked: likeStatus,
                                ),
                                const Text(
                                  'Like',
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 12),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            InkWell(
                              onTap: () async {},
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
                            // InkWell(
                            //   onTap: () async {},
                            //   child: Column(
                            //     children: const [
                            //       Icon(
                            //         Icons.file_download,
                            //         color: AppColors.white,
                            //         size: 20,
                            //       ),
                            //       Text(
                            //         'Download',
                            //         style: TextStyle(
                            //             color: AppColors.white, fontSize: 12),
                            //       )
                            //     ],
                            //   ),
                            // )
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
                                              left: 0, right: 20),
                                          child: HorizontalVideoBoxWidget(
                                              ontap: () {
                                                resetPlayer(
                                                    videoLink:
                                                        similarVideoData[index]
                                                            .video!,
                                                    title:
                                                        similarVideoData[index]
                                                            .title!,
                                                    desc:
                                                        similarVideoData[index]
                                                            .desc!,
                                                    id: similarVideoData[index]
                                                        .id!);
                                                if (ratedListVideos
                                                    .contains(movieID)) {
                                                  setState(() {
                                                    likeStatus = true;
                                                    movieID =
                                                        similarVideoData[index]
                                                            .id!;
                                                  });
                                                } else {
                                                  setState(() {
                                                    likeStatus = false;
                                                    movieID =
                                                        similarVideoData[index]
                                                            .id!;
                                                  });
                                                }
                                              },
                                              decs:
                                                  similarVideoData[index].desc!,
                                              img: similarVideoData[index].img!,
                                              title: similarVideoData[index]
                                                  .title!));
                                    }),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
      ),
    );
  }
}
