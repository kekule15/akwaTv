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
                Stack(
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            // color: Colors.red,
                            border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: AppColors.termsTextColor))),
                        width: MediaQuery.of(context).size.width,
                        height: 340,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 240,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              videoData!.data![1].img!),
                                          fit: BoxFit.cover)),
                                ),
                                Positioned(
                                    right: 100,
                                    left: 100,
                                    top: 100,
                                    bottom: 100,
                                    child: playButtonWidget(
                                      icon: Icon(
                                        Icons.play_arrow,
                                        color: AppColors.white,
                                        size: 30,
                                      ),
                                    )),
                              ],
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: 85,
                                //color: AppColors.primary,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      dense: true,
                                      minVerticalPadding: 0.0,
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                        videoData.data![1].title!,
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${videoData.data![1].year!}  |",
                                                style: const TextStyle(
                                                  color: AppColors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                "${videoData.data![1].ageLimit.toString()}+",
                                                style: const TextStyle(
                                                  color: AppColors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      // trailing: InkWell(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 VideoDetailsPage(
                                      //                   title: videoData
                                      //                       .data![1].title!,
                                      //                   image: videoData
                                      //                       .data![1].img,
                                      //                 )));
                                      //   },
                                      //   child: const Icon(
                                      //     Icons.info,
                                      //     size: 30,
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
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
                      padding: const EdgeInsets.fromLTRB(10, 350, 0, 10),
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
    );
  }
}
