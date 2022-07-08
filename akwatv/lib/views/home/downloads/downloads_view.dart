import 'package:akwatv/enums/text_field_type_enum.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/customfield.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownLoadsPage extends ConsumerStatefulWidget {
  const DownLoadsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DownLoadsPageState();
}

class _DownLoadsPageState extends ConsumerState<DownLoadsPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'My Downloads',
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
                  PlayModel.movieList.length,
                  (index) => Card(
                        color: AppColors.termsTextColor,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: 100,
                                    child: ImageWidget(
                                      asset:
                                          PlayModel.movieList[index].movieImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    PlayModel.movieList[index].movieName,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 12.sp),
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
