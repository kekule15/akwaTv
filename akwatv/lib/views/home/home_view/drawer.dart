import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/responsive.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/views/home/home_view/drawer_widget.dart';
import 'package:akwatv/views/home/home_view/video_category_page.dart';
import 'package:akwatv/views/home/navigation_page.dart';
import 'package:akwatv/views/home/profile/edit_profile.dart';
import 'package:akwatv/views/home/profile/profile_view.dart';
import 'package:akwatv/views/home/settings/settings_screen.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDrawerPage extends ConsumerStatefulWidget {
  const MyDrawerPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyDrawerPageState();
}

class _MyDrawerPageState extends ConsumerState<MyDrawerPage> {
  @override
  Widget build(BuildContext context) {
    final videoProvider = ref.watch(videoViewModel);
    final viewModel = ref.watch(homeViewModel);
    var data = viewModel.subDrawerList();
    return Drawer(
      elevation: 10,
      backgroundColor: AppColors.black,
      child: Container(
        width: 500,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            border:
                Border(right: BorderSide(width: 0.4, color: AppColors.gray))),
        child: Stack(
          children: [
            InkWell(
              onTap: (() {
                Get.to((const EditProfilePage()));
              }),
              child: SizedBox(
                height: 170.h,
                child: DrawerHeader(
                  padding: EdgeInsets.fromLTRB(ySpace2, 0, 0, 15.h),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10.h),
                  decoration: const BoxDecoration(
                    color: AppColors.termsTextColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PreferenceUtils.getString(key: 'avatar') != ''
                          ? CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColors.primary,
                              backgroundImage: NetworkImage(
                                  PreferenceUtils.getString(key: 'avatar')),
                            )
                          : const CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColors.primary,
                              child: const Icon(Icons.person)),
                      const SizedBox(
                        width: ySpace1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PreferenceUtils.getString(key: 'username'),
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: AppColors.white),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: ySpaceMin, bottom: ySpaceMin),
                            height: ySpaceMin - 4.5,
                            width: SizeConfig.xMargin(context, 30.w),
                            decoration: const BoxDecoration(
                              color: AppColors.gray,
                            ),
                          ),
                          SizedBox(
                            width: 120.w,
                            child: Text(
                              PreferenceUtils.getString(key: 'email'),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: AppColors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Akwa Amaka Originals',
                      style: TextStyle(color: AppColors.white, fontSize: 12.sp),
                    ),
                  ),
                  const SizedBox(
                    height: ySpace1,
                  ),
                  videoProvider.categoryListData.data == null
                      ? const SizedBox(
                          height: 30,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                videoProvider
                                    .categoryListData.data!.data!.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => const VideoCategoryPage(),
                                          arguments: videoProvider
                                              .categoryListData
                                              .data!
                                              .data![index]);
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.movie,
                                          size: 20,
                                          color: AppColors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          videoProvider
                                              .categoryListData
                                              .data!
                                              .data![index]
                                              .genre!
                                              .capitalizeFirst!,
                                          style: const TextStyle(
                                              color: AppColors.white,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ),
                  const Divider(
                    color: AppColors.gray,
                  ),
                  const SizedBox(
                    height: ySpaceMid,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          data.length,
                          (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: drawerWidget(
                                  onTap: data[index]["onTap"],
                                  title: data[index]['title'],
                                  icon: data[index]['icon'],
                                  iconColor: AppColors.white,
                                  titleColor: AppColors.white)),
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 20),
                      child: drawerWidget(
                          onTap: () {
                            showDialogWithFields();
                          },
                          title: 'Logout',
                          icon: Icons.logout,
                          iconColor: AppColors.primary,
                          titleColor: AppColors.primary)),
                  const SizedBox(
                    height: ySpace3 * 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDialogWithFields() {
    final viewModel = ref.watch(loginViewModel);
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('No', style: TextStyle(color: AppColors.gray)),
            ),
            TextButton(
              onPressed: () async {
                viewModel.logoutNow();
              },
              child: Text('Yes', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        );
      },
    );
  }
}
