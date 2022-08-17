import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/home/home_view/video_details.dart';
import 'package:akwatv/views/home/home_view/widgets/vidoe_layout_widget.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final searchController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final videoService = ref.watch(videoViewModel);
    return Scaffold(
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: ySpace3 * 2,
                ),
                CustomField(
                  style: const TextStyle(color: AppColors.white),
                  pIcon: const Icon(
                    Icons.search,
                    color: AppColors.white,
                    size: 20,
                  ),
                  sIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        videoService.searchMovieData = [];
                        var form = formKey.currentState;
                        if (form!.validate()) {
                          form.save();
                          videoService.searchMovieService(
                              title: searchController.text == ''
                                  ? 'all'
                                  : searchController.text.trim());
                        }
                      },
                      child: Text(
                        'search'.tr,
                        style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  validate: true,
                  fillColor: AppColors.gray4,
                  controller: searchController,
                  hint: 'searchBy'.tr,
                  hintstyle: const TextStyle(color: AppColors.white),
                  fieldType: TextFieldType.name,
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(100)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'topSearched'.tr,
                style: TextStyle(color: AppColors.white, fontSize: 16.sp),
              ),
              const SizedBox(
                height: 30,
              ),
              videoService.isSearch
                  ? const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : videoService.searchMovieData.isEmpty == true
                      ? Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              const SvgImage(
                                asset: emptyVid,
                                height: 200,
                                width: 200,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                'noMovieFetched'.tr,
                                style: const TextStyle(
                                    color: AppColors.white, fontSize: 17),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: List.generate(
                              videoService.searchMovieData.length, (index) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: VideoLayoutWidget(
                                    title: videoService
                                        .searchMovieData[index].title!,
                                    img: videoService
                                        .searchMovieData[index].img!,
                                    subtitle: videoService
                                        .searchMovieData[index].desc!,
                                    onTap: () {
                                      Get.to(
                                          () => VideoDetailsPage(
                                                videoData: videoService
                                                    .searchMovieData[index],
                                              ),
                                          arguments: videoService
                                              .searchMovieData[index]);
                                    },
                                    icon: Icons.done,
                                    iconTap: () {
                                      // deleteWatchList(
                                      //   data: watchListVideoData[index],
                                      //   movieID: watchListVideoData[index].id,
                                      // );
                                    },
                                    iconColor: AppColors.white));
                          }),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
