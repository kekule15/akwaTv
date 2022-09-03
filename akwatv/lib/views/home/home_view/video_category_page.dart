import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/models/category_model.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/providers/network_provider.dart';
import 'package:akwatv/providers/video_controller_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/home/home_view/video_details.dart';
import 'package:akwatv/views/home/home_view/video_screen.dart';
import 'package:akwatv/views/home/home_view/widgets/vidoe_layout_widget.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/network_widget.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoCategoryPage extends ConsumerStatefulWidget {
  const VideoCategoryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoCategoryPageState();
}

class _VideoCategoryPageState extends ConsumerState<VideoCategoryPage> {
  List<Datum> categoryVideoData = [];

  @override
  void didChangeDependencies() {
    var categoryData = ModalRoute.of(context)?.settings.arguments as Items;
    final videoProvider = ref.watch(videoViewModel);
    var videoData = videoProvider.listVideoData.data;

    for (var data in videoData!.data!
        .where((element) => categoryData.content!.contains(element.id))) {
      print('object yes');
      categoryVideoData.add(data);
      print(categoryVideoData.length);
    }

    super.didChangeDependencies();
  }

  List<Datum> seachedVideoData = [];

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var categoryData = ModalRoute.of(context)?.settings.arguments as Items;
    final videoProvider = ref.watch(videoViewModel);
    final network = ref.watch(networkProvider);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.black,
          //automaticallyImplyLeading: false,
          title: Text(
            categoryData.genre!.capitalizeFirst!,
            style: TextStyle(color: AppColors.white, fontSize: 22),
          ),
        ),
        body: network.isCheck == true
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
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
                        itemCount: (seachedVideoData != null &&
                                seachedVideoData.isNotEmpty)
                            ? seachedVideoData.length
                            : categoryVideoData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: (seachedVideoData != null &&
                                    seachedVideoData.isNotEmpty)
                                ? _showBottomSheetWithSearch(
                                    index, seachedVideoData)
                                : _showBottomSheetWithSearch(
                                    index, categoryVideoData),
                          );
                        }),
                    const SizedBox(
                      height: ySpace3,
                    ),
                  ],
                ),
              )
            : networkWidget());
  }

  Widget _showBottomSheetWithSearch(int index, List<Datum> myList) {
    var videoCon = ref.watch(videoControllerProvider);
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: VideoLayoutWidget(
            title: myList[index].title!,
            img: myList[index].img!,
            subtitle: myList[index].desc!,
            onTap: () {
              videoCon.initPlayer(
                link: myList[index].video!,
                description: myList[index].desc!,
                title: myList[index].title!,
                movieId: myList[index].id,
              );
              videoCon.sortSimilarVideos(data: myList[index]);
              Get.to(() => VideoScreen(url: myList[index].video!));
            },
            icon: Icons.done,
            iconTap: () {},
            iconColor: AppColors.white));
  }

  List<Datum> _buildSearchList(String userSearchTerm) {
    List<Datum> searchList = [];

    for (int i = 0; i < categoryVideoData.length; i++) {
      String name = categoryVideoData[i].title!;
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        searchList.add(categoryVideoData[i]);
      } else {
        searchList;
      }
    }
    return searchList;
  }
}
