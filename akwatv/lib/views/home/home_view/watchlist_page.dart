import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/views/home/home_view/video_details.dart';
import 'package:akwatv/views/home/home_view/widgets/vidoe_layout_widget.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ViewAllWatchList extends ConsumerStatefulWidget {
  const ViewAllWatchList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewAllWatchListState();
}

class _ViewAllWatchListState extends ConsumerState<ViewAllWatchList> {
  @override
  Widget build(BuildContext context) {
    var watchListVideoData =
        ModalRoute.of(context)?.settings.arguments as List<Datum>;
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
          Column(
            children: List.generate(
                watchListVideoData.length,
                (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: VideoLayoutWidget(
                        title: watchListVideoData[index].title!,
                        img: watchListVideoData[index].img!,
                        subtitle: watchListVideoData[index].desc!,
                        onTap: () {
                          Get.to(
                              () => VideoDetailsPage(
                                    videoData: watchListVideoData[index],
                                  ),
                              arguments: watchListVideoData[index]);
                        },
                        icon: Icons.close,
                        iconTap: () {
                          deleteWatchList(
                            data: watchListVideoData[index],
                            movieID: watchListVideoData[index].id,
                          );
                        },
                        iconColor: AppColors.primary))),
          ),
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
                videoProvider.deleteWatchListservice(movieID: movieID);
                watchListVideoData.remove(data);

                Future.delayed(const Duration(seconds: 1), () {
                  videoProvider.getAllWatchList();
                  // getWatchList();
                  Get.back();
                });
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
