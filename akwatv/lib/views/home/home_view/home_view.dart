import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/home/home_view/video_details.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:akwatv/widgets/video_box_widget.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';
import 'package:get/get.dart';

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

  bool switchMode = false;

  @override
  Widget build(BuildContext context) {
    final _videoViewModel = ref.watch(videoViewModel);
    var videoData = _videoViewModel.listVideoData.data;

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
          : Stack(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        // color: Colors.red,
                        ),
                    width: MediaQuery.of(context).size.width,
                    height: 330,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => const VideoDetailsPage(),
                                arguments: videoData!.data![0]);
                          },
                          child: Container(
                            height: 330,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        NetworkImage(videoData!.data![1].img!),
                                    fit: BoxFit.cover)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      // color: Colors.red,
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [
                                        0.08,
                                        1.9
                                      ],
                                          colors: [
                                        AppColors.textBlack.withOpacity(0.1),
                                        AppColors.black.withOpacity(0.9)
                                      ])),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [
                                            0.08,
                                            1.9
                                          ],
                                          colors: [
                                            AppColors.textBlack
                                                .withOpacity(0.1),
                                            AppColors.black.withOpacity(0.9)
                                          ]),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                videoData.data![0].title!,
                                                style: const TextStyle(
                                                    color: AppColors.white),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    videoData.data![0].year!,
                                                    style: const TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 9),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Container(
                                                    height: 16,
                                                    width: 1,
                                                    color: AppColors.gray,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "${videoData.data![0].ageLimit!} +",
                                                    style: const TextStyle(
                                                        color: AppColors.white,
                                                        fontSize: 9),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          CircleAvatar(
                                            radius: 14,
                                            backgroundColor: AppColors.white
                                                .withOpacity(0.2),
                                            child: const Center(
                                              child: Icon(
                                                Icons.share,
                                                color: AppColors.white,
                                                size: 20,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Positioned(
                            right: 100,
                            left: 100,
                            top: 100,
                            bottom: 100,
                            child: Icon(
                              Icons.play_circle_outline_outlined,
                              color: AppColors.white,
                              size: 50,
                            )),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 340, 0, 10),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    children: [
                      const Text(
                        'Akwa Amaka Originals',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: videoData.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: VideoBoxWidget(
                                ontap: () {
                                  Get.to(() => const VideoDetailsPage(),
                                      arguments: videoData.data![index]);
                                },
                                img: videoData.data![index].img!,
                                title: videoData.data![index].title!,
                                description: videoData.data![index].desc!,
                              ),
                            );
                          }),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
