import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/providers/video_controller_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/views/home/home_view/video_details.dart';
import 'package:akwatv/views/home/home_view/video_screen.dart';
import 'package:akwatv/views/home/home_view/widgets/vidoe_layout_widget.dart';
import 'package:akwatv/views/home/subscription/widgets/sub_dialogs.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../utils/temporary_storage.dart';

class ViewAllWatchList extends ConsumerStatefulWidget {
  const ViewAllWatchList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewAllWatchListState();
}

class _ViewAllWatchListState extends ConsumerState<ViewAllWatchList> {
  List<Datum> seachedVideoData = [];

  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var videoCon = ref.watch(videoControllerProvider);
    var watchListVideoData =
        ModalRoute.of(context)?.settings.arguments as List<Datum>;
    Widget _showBottomSheetWithSearch(int index, List<Datum> myList) {
      return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: VideoLayoutWidget(
              title: myList[index].title!,
              img: myList[index].img!,
              subtitle: myList[index].desc!,
              onTap: LocalStorageManager.box.read('isSubActive') == true
                  ? () {
                      videoCon.initPlayer(
                        link: watchListVideoData[index].video!,
                        description: watchListVideoData[index].desc!,
                        title: watchListVideoData[index].title!,
                        movieId: watchListVideoData[index].id,
                      );
                      videoCon.chewieController!.play();
                      videoCon.sortSimilarVideos(
                          data: watchListVideoData[index]);
                      Get.to(() =>
                          VideoScreen(url: watchListVideoData[index].video!));
                    }
                  : () {
                      checkSubscriptionStatus(context);
                    },
              icon: Icons.done,
              iconTap: () {},
              iconColor: AppColors.white));
    }

    List<Datum> _buildSearchList(String userSearchTerm) {
      List<Datum> searchList = [];

      for (int i = 0; i < watchListVideoData.length; i++) {
        String name = watchListVideoData[i].title!;
        if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
          searchList.add(watchListVideoData[i]);
        } else {
          searchList;
        }
      }
      return searchList;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        //automaticallyImplyLeading: false,
        title: const Text(
          'WatchList',
          style: TextStyle(color: AppColors.white, fontSize: 22),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 30,
          ),
          CustomField(
            style: const TextStyle(color: AppColors.white),
            pIcon: const Icon(
              Icons.search,
              color: AppColors.white,
              size: 20,
            ),
            onChanged: (value) {
              setState(() {
                seachedVideoData = _buildSearchList(value);
              });
            },
            sIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      textController.clear();
                      seachedVideoData.clear();
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  )),
            ),
            validate: true,
            fillColor: AppColors.gray4,
            controller: textController,
            hint: 'searchBy'.tr,
            hintstyle: const TextStyle(color: AppColors.white),
            fieldType: TextFieldType.name,
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount:
                  (seachedVideoData != null && seachedVideoData.isNotEmpty)
                      ? seachedVideoData.length
                      : watchListVideoData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: (seachedVideoData != null &&
                          seachedVideoData.isNotEmpty)
                      ? _showBottomSheetWithSearch(index, seachedVideoData)
                      : _showBottomSheetWithSearch(index, watchListVideoData),
                );
              }),
          const SizedBox(
            height: ySpace3,
          ),

          // Column(
          //   children: List.generate(
          //       watchListVideoData.length,
          //       (index) => Padding(
          //           padding: const EdgeInsets.only(bottom: 10),
          //           child: VideoLayoutWidget(
          //               title: watchListVideoData[index].title!,
          //               img: watchListVideoData[index].img!,
          //               subtitle: watchListVideoData[index].desc!,
          //               onTap: () {
          //                 Get.to(
          //                     () => VideoDetailsPage(
          //                           videoData: watchListVideoData[index],
          //                         ),
          //                     arguments: watchListVideoData[index]);
          //               },
          //               icon: Icons.close,
          //               iconTap: () {
          //                 deleteWatchList(
          //                   data: watchListVideoData[index],
          //                   movieID: watchListVideoData[index].id,
          //                 );
          //               },
          //               iconColor: AppColors.primary))),
          // ),
        ],
      ),
    );
  }

  void deleteWatchList({required dynamic movieID, required dynamic data}) {
    final videoProvider = ref.watch(videoViewModel);
    var watchListVideoData =
        ModalRoute.of(context)?.settings.arguments as List<Datum>;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Delete Item',
            textAlign: TextAlign.center,
          ),
          content: videoProvider.deleteTOListBTN
              ? SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                )
              : const Text(
                  'Sure you want to delete this saved Watchlist?',
                  textAlign: TextAlign.center,
                ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No', style: TextStyle(color: AppColors.gray)),
            ),
            TextButton(
              onPressed: () async {
                videoProvider.deleteWatchListservice(
                    movieID: movieID, item: data);
                // watchListVideoData.remove(data);

                // Future.delayed(const Duration(seconds: 1), () {
                //   videoProvider.getAllWatchList();
                //   // getWatchList();
                //   Get.back();
                // });
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }
}
