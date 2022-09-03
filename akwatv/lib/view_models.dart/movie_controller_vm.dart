import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class MovieControllerViewModel extends BaseViewModel {
  List<Datum> similarVideoData = [];
  Datum? passedVideoData;
  String mTitle = '';
  String mDescription = '';
  String mMovieId = '';
  String mLink = '';
  bool likeStatus = false;
  MovieControllerViewModel(Reader read) : super(read) {
    initPlayer(
      link: mLink,
      description: mDescription,
      title: mTitle,
      movieId: mMovieId,
    );
  }
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;
  void initPlayer({
    required dynamic link,
    required String description,
    required String title,
    required dynamic movieId,
  }) async {
    mLink = link;
    mDescription = description;
    mMovieId = movieId;
    mTitle = title;
    notifyListeners();

    // check for rated videos
    sortRatedVideos();

    videoPlayerController = VideoPlayerController.network(link);

    videoPlayerController!.initialize();

    debugPrint("selected video link $link");

    chewieController = ChewieController(
        aspectRatio: 16 / 9,
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        autoInitialize: true,
        looping: false,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: false,
        materialProgressColors: ChewieProgressColors(
          backgroundColor: AppColors.gray,
          playedColor: AppColors.primary,
        ),
        placeholder: Container(
          color: Colors.black87,
          child: const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          )),
        ),
        errorBuilder: ((context, errorMessage) {
          return InkWell(
            onTap: () {},
            child: const Center(
              child: Icon(
                Icons.refresh,
                color: AppColors.primary,
                size: 35,
              ),
            ),
          );
        }));
    notifyListeners();
  }

  void disposePlayer() {
    chewieController!.pause();
    chewieController!.dispose();
    videoPlayerController!.dispose();
    similarVideoData = [];
    ratedListVideos = [];
    notifyListeners();
    debugPrint('Disposed controller');

    /// dispose player
  }

  //sort video list to get similar videos
  sortSimilarVideos({required Datum data}) async {
    final _videoViewModel = read(videoViewModel);
    var similarVideos = _videoViewModel.listVideoData.data;
    for (var element in similarVideos!.data!) {
      if (element.genre == data.genre!) {
        similarVideoData.add(element);
        notifyListeners();
      }
    }
  }

  List<String> ratedListVideos = [];
  // sort rated videos
  sortRatedVideos() async {
    final loginViewModel = read(viewModel);
    var ratedList = loginViewModel.userProfileData.data;

    for (var element in ratedList!.data!.ratedList!) {
      ratedListVideos.add(element);
      checkRatedVideo();
    }
  }

  checkRatedVideo() async {
    if (ratedListVideos.contains(mMovieId)) {
      likeStatus = true;
      notifyListeners();
    } else {
      likeStatus = false;
      notifyListeners();
    }
  }

  checkRatedStatus() async {
    if (ratedListVideos.contains(mMovieId)) {
      ratedListVideos.remove(mMovieId);
      likeStatus = false;
      notifyListeners();
    } else {
      ratedListVideos.add(mMovieId);
      likeStatus = true;
      notifyListeners();
    }
  }
}
