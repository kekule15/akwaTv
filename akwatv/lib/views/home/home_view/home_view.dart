import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openMyDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawerPage(),
      body: Stack(
        children: [
          Container(
            child: Center(
              child: Text(
                'Home View',
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 70, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: AppColors.white,
                    size: 25.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
