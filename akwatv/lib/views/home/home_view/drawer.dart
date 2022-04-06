import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      backgroundColor: AppColors.black,
      child: SizedBox(
        width: 500,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            const SizedBox(
              height: ySpace1,
            ),
            const Text(
              'User1',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.white),
            ),
            const SizedBox(
              height: ySpace1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.settings,
                    size: 20.w,
                    color: AppColors.white,
                  ),
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.sync_alt,
                      size: 20.w,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: ySpace1,
            ),
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
                        onTap: () {},
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
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(color: AppColors.white, fontSize: 13.sp),
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
    );
  }
}
