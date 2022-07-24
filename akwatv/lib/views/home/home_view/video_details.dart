import 'dart:io' as io;

import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/views/home/home_view/text.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/video_box_widget.dart';
import 'package:better_player/better_player.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  Datum videoData;

  VideoDetailsPage({Key? key, required this.videoData}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  DioCacheManager? _dioCacheManager;
  String? _myData;

  BetterPlayerController? _betterPlayerController;
  List<Datum> similarVideoData = [];
  String url = '';
  String description = '';
  String mtitle = '';
  dynamic movieID = '';
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

    final Dio dio = Dio();
    bool loading = false;
    double progress = 0;
    Future<bool> _requestPermission(Permission permission) async {
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      }
      return false;
    }

    Future<bool> saveVideo(String url, String fileName) async {
      Directory? directory;
      try {
        if (Platform.isAndroid) {
          if (await _requestPermission(Permission.storage)) {
            directory = await getApplicationDocumentsDirectory();
            String newPath = "";
            print(directory);
            List<String> paths = directory.path.split("/");
            for (int x = 1; x < paths.length; x++) {
              String folder = paths[x];
              if (folder != "Android") {
                newPath += "/" + folder;
              } else {
                break;
              }
            }
            newPath = newPath + "/Kekule";
            directory = Directory(newPath);
          } else {
            return false;
          }
        } else {
          if (await _requestPermission(Permission.photos)) {
            directory = await getTemporaryDirectory();
          } else {
            return false;
          }
        }
        File saveFile = File(directory.path + "/$fileName");
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          await dio.download(url, saveFile.path,
              onReceiveProgress: (value1, value2) {
            setState(() {
              progress = value1 / value2;
            });
          });
          if (Platform.isIOS) {
            // await ImageGallerySaver.saveFile(saveFile.path,
            //     isReturnPathOfIOS: true);
          }
          return true;
        }
        return false;
      } catch (e) {
        print(e);
        return false;
      }
    }

    downloadFile(String url) async {
      setState(() {
        loading = true;
        progress = 0;
      });
      bool downloaded = await saveVideo(url, "video.mp4");
      if (downloaded) {
        print("File Downloaded");
      } else {
        print("Problem Downloading File");
      }
      setState(() {
        loading = false;
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
                              onTap: () async {
                                // Get.to(() => TesterPage());
                                List file = [];
                                var directory =
                                    (await getApplicationDocumentsDirectory())
                                        .path;

                                print(io.Directory("$directory/")
                                    .listSync()
                                    .where((element) =>
                                        element.path ==
                                        '/data/user/0/com.example.akwatv/app_flutter/Kekule'));

                                print('$directory/$movieID.mp4');
                                print(directory);
                              },
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
                              onTap: () async {
                                // await DefaultCacheManager().downloadFile(url);
                                // var file = await DefaultCacheManager()
                                //     .getSingleFile(url);
                                // print(" augustus $file");
                                // await openFile(
                                //     url: url,
                                //     fileName:
                                //         "${mtitle.replaceAll(RegExp(r"\s+\b|\b\s"), "")}.mp4");

                                // var dir =
                                //     await getApplicationDocumentsDirectory();
                                // String filePath = "/$movieID.mp4";
                                // String fullPath = dir.path + filePath;
                                // var videoResponse =
                                //     await Dio().download(url, fullPath);

                                // if (videoResponse.statusCode == 200) {
                                //   //videoPath = fullPath;
                                //   print("Downloaded: $fullPath");
                                // } else {
                                //   print("Download error");
                                // }

                                downloadFile(url);
                              },
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
                                                    title:
                                                        similarVideoData[index]
                                                            .title!,
                                                    desc:
                                                        similarVideoData[index]
                                                            .desc!,
                                                    id: similarVideoData[index]
                                                        .id!);
                                              },
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
                  // Text(
                  //   _myData ?? 'Hello guy',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(color: AppColors.white),
                  // ),
                ],
              ),
      ),
    );
  }

  // Future openFile({required String url, required String fileName}) async {
  //   final file = await downloadFile(url, fileName);
  //   if (file == null) {
  //   } else {
  //     print('path: ${file.path}');
  //   }
  // }

  // // Download file into private folder not visible to user

  // Future<File?> downloadFile(String url, String name) async {
  //   // storage permission ask
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //   }
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final file = File('${appStorage.path}/$name');
  //   try {
  //     final response = await Dio().get(url,
  //         options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           receiveTimeout: 0,
  //         ));

  //     final raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     print(file);
  //     await raf.close();

  //     return file;
  //   } catch (e) {
  //     return null;
  //   }
  // }

}
