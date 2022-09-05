import 'package:akwatv/providers/network_provider.dart';
import 'package:akwatv/providers/video_controller_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/like_button.dart';
import 'package:akwatv/widgets/network_widget.dart';
import 'package:akwatv/widgets/video_box_widget.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends ConsumerStatefulWidget {
  final String url;
  const VideoScreen({Key? key, required this.url}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoScreenState();
}

class _VideoScreenState extends ConsumerState<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    var videoCon = ref.watch(videoControllerProvider);

    Future<bool> _onBackPressed() {
      return Future.delayed(const Duration(milliseconds: 1000), () {
        videoCon.disposePlayer();

        Navigator.pop(context);

        return false;
      });
    }

    final _videoViewModel = ref.watch(videoViewModel);
    //final network = ref.watch(networkProvider);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Chewie(
                    controller: videoCon.chewieController!,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _onBackPressed();
                      },
                      child: const CircleAvatar(
                        radius: 17,
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                          color: AppColors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 230),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: generalHorizontalPadding),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      videoCon.mTitle,
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        videoCon.mDescription,
                        style: TextStyle(
                            color: AppColors.white.withOpacity(0.8),
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _videoViewModel.addToWatchListService(
                                movieID: videoCon.mMovieId);
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
                                videoCon.checkRatedStatus();
                                _videoViewModel.likeVideoButton(
                                    movieID: videoCon.mMovieId);
                              },
                              isLiked: videoCon.likeStatus,
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
                        // InkWell(
                        //   onTap: () async {},
                        //   child: Column(
                        //     children: const [
                        //       Icon(
                        //         Icons.share,
                        //         color: AppColors.white,
                        //         size: 20,
                        //       ),
                        //       Text(
                        //         'Share',
                        //         style: TextStyle(
                        //             color: AppColors.white, fontSize: 12),
                        //       )
                        //     ],
                        //   ),
                        // ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SIMILAR MOVIES',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 13),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        videoCon.similarVideoData.isEmpty
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
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: videoCon.similarVideoData.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 20),
                                          child: HorizontalVideoBoxWidget(
                                              ontap: () {
                                                videoCon.chewieController!
                                                    .dispose();
                                                videoCon.chewieController!
                                                    .pause();
                                                videoCon.initPlayer(
                                                    link: videoCon
                                                        .similarVideoData[index]
                                                        .video,
                                                    description: videoCon
                                                        .similarVideoData[index]
                                                        .desc!,
                                                    title: videoCon
                                                        .similarVideoData[index]
                                                        .title!,
                                                    movieId: videoCon
                                                        .similarVideoData[index]
                                                        .id);
                                              },
                                              decs: videoCon
                                                  .similarVideoData[index]
                                                  .desc!,
                                              img: videoCon
                                                  .similarVideoData[index].img!,
                                              title: videoCon
                                                  .similarVideoData[index]
                                                  .title!));
                                    }),
                              ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
