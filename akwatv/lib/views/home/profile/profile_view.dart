import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  List<String> userDetails = [
    'User 1',
    '09014700476',
    'rbsnation111@gmail.com',
    'Password',
  ];
  List<String> userDetailIcon = [
    userIcon,
    callIcon,
    emailIcon,
    passwordIcon,
  ];
 final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openMyDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
      drawer: MyDrawerPage(),
      body: Stack(children: [
        SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
              ),
              const Text(
                'User1',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white),
              ),
              const SizedBox(
                height: ySpace1,
              ),
              CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person),
              ),
            ],
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
        Padding(
          padding: const EdgeInsets.only(top: 300),
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TabBar(
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: AppColors.white,
                        indicator: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: AppColors.primary)),
                        ),
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Favourite"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Bookmarks"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Account"),
                            ),
                          ),
                        ]),
                  ),
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.gray,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBarView(children: [
                      //Favourite Tab
                      MediaQuery.removePadding(
                        context: context,
                        removeRight: false,
                        removeTop: true,
                        removeLeft: false,
                        child: ListView(
                          children: [
                            Text(
                              'Select Feedback Category',
                              style: TextStyle(fontSize: 17.sp),
                            ),
                          ],
                        ),
                      ),
                      //Bookmark Tab

                      ListView(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              child: Column(
                                children: [
                                  Text(
                                    'Continue Watching ',
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        color: AppColors.white),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      //Account Tab
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    userDetails.length,
                                    (index) => ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          horizontalTitleGap: 0,
                                          leading: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: SvgImage(
                                                asset: userDetailIcon[index]),
                                          ),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                              userDetails[index],
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.white),
                                            ),
                                          ),
                                        ))),
                            const SizedBox(
                              height: ySpace2,
                            ),
                            CustomButton(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: AppColors.white,
                                      size: 15.w,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: AppColors.white),
                                    ),
                                  ],
                                ),
                                onclick: () {},
                                color: AppColors.primary,
                                borderColor: false)
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
