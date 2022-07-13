import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/responsive.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/home/navigation_page.dart';
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
  List<String> movieTypes = [
    'TV Shows',
    'Action',
    'Romance',
    'Thrillers',
    'Sci-Fi & Fantancy',
    'Dramas',
    'Comedies',
    'Family',
  ];
  List<String> subs = [
    'Settings',
    'Account',
    'Help',
  ];
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
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
            SizedBox(
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
                    box.read('avatar') != null
                        ? CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.primary,
                            backgroundImage: NetworkImage(box.read('avatar')),
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
                          box.read('username'),
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
                            box.read('email'),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          movieTypes.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                movieTypes[index],
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 13.sp),
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
                          subs.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () {
                                switch (subs[index]) {
                                  case 'Settings':
                                    Get.to(() => const SettingsPage());

                                    break;
                                  case 'Account':
                                    ref.watch(homeViewModel).selectedIndex = 3;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeNavigation()));

                                    break;
                                  case 'Help':
                                    Get.to(() {
                                      const SettingsPage();
                                    });

                                    break;

                                  default:
                                }
                              },
                              child: Text(
                                subs[index],
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 13.sp),
                              ),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 20),
                    child: InkWell(
                      onTap: () {
                        showDialogWithFields();
                      },
                      child: Row(
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(
                                color: AppColors.white, fontSize: 13.sp),
                          ),
                          const SizedBox(
                            width: ySpace1,
                          ),
                          Icon(
                            Icons.logout,
                            size: 20.w,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
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
    final _viewModel = ref.watch(homeViewModel);
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                box.remove('token');
                box.remove(
                  'phone',
                );
                box.remove(
                  'avatar',
                );
                box.remove(
                  'email',
                );
                box.remove(
                  'username',
                );
                box.remove(
                  'verified',
                );
                box.remove(
                  'cloudId',
                );
                box.remove(
                  'userId',
                );

                _viewModel.changeIndex(0);
                box.erase();
                Get.offAll(() => const AuthScreen());
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }



}
