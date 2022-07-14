import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/models/category_model.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/home/home_view/video_details.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
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
  final searchController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    var categoryData = ModalRoute.of(context)?.settings.arguments as Items;
    final videoProvider = ref.watch(videoViewModel);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        title: Text(
          categoryData.genre!.capitalizeFirst!,
          style: TextStyle(color: AppColors.white, fontSize: 16.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: ySpace1,
            ),
            Column(
              children: List.generate(
                  categoryVideoData.length,
                  (index) => InkWell(
                        onTap: () {
                          Get.to(
                              () => VideoDetailsPage(
                                    videoData: categoryVideoData[index],
                                  ),
                              arguments: categoryVideoData[index]);
                        },
                        child: Card(
                          color: AppColors.termsTextColor,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  categoryVideoData[index]
                                                      .img!),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          categoryVideoData[index].title!,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 12.sp),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            categoryVideoData[index].desc!,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: AppColors.white,
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  child: playButtonWidget(
                                    icon: Icon(
                                      Icons.check,
                                      color: AppColors.white,
                                      size: 10.w,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
            ),
            const SizedBox(
              height: ySpace3,
            ),
          ],
        ),
      ),
    );
  }
}
