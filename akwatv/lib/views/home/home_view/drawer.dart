import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/providers.dart';
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
    final _loginViewModel = ref.watch(viewModel);

    return SafeArea(
      child: Drawer(
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
                height: 150,
                child: Column(
                  children: [
                    const SizedBox(
                      height: ySpace1,
                    ),
                    Text(
                      _loginViewModel.userProfileData.data!.data!.username!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.white),
                    ),
                    const SizedBox(
                      height: ySpace1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const SettingsPage());
                            },
                            child: Icon(
                              Icons.settings,
                              size: 25.w,
                              color: AppColors.white,
                            ),
                          ),
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor: AppColors.primary,
                            child: const Icon(Icons.person),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.sync_alt,
                              size: 25.w,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: ySpace1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Akwa Amaka Originals',
                        style:
                            TextStyle(color: AppColors.white, fontSize: 12.sp),
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
                                      ref.watch(homeViewModel).selectedIndex =
                                          3;
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
                          box.erase();
                          Get.offAll(() => const AuthScreen());
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
      ),
    );
  }
}
