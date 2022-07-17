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

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  pIcon: const Icon(
                    Icons.search,
                    color: AppColors.white,
                    size: 20,
                  ),
                  validator: () {},
                  onChanged: (value) {},
                  fillColor: AppColors.gray.withOpacity(0.4),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  controller: searchController,
                  hint: 'search by title, actor...',
                  hintstyle: const TextStyle(color: AppColors.white),
                  fieldType: TextFieldType.name,
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(100)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Text(
              'Top Searched',
              style: TextStyle(color: AppColors.white, fontSize: 16.sp),
            ),
            const SizedBox(
              height: ySpace1,
            ),
          ],
        ),
      ),
    );
  }
}
