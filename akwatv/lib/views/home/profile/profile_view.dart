import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/home/notifications/notification_screen.dart';
import 'package:akwatv/views/home/profile/edit_profile.dart';
import 'package:akwatv/views/home/settings/settings_screen.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';

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

  GetStorage box = GetStorage();

  XFile? image;
  final ImagePicker _picker = ImagePicker();

  takePhoto(ImageSource source, cxt) async {
    final loginViewModel = ref.watch(viewModel);
    setState(() {
      loginViewModel.uploadPicBTN = true;
    });
    final pickedFile = await _picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
      });
      String fileName = image!.path.split('/').last;
      loginViewModel.uploadProfilePic(
        image: await DIO.MultipartFile.fromFile(image!.path,
            filename: fileName, contentType: MediaType('image', 'jpg')),
      );

      setState(() {
        loginViewModel.uploadPicBTN = false;
      });
    }

    // Navigator.pop(cxt);
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = ref.watch(viewModel);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawerPage(),
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
              InkWell(
                  onTap: () {
                    takePhoto(ImageSource.gallery, context);
                  },
                  child: box.read('avatar') == null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primary,
                          child: loginViewModel.uploadPicBTN
                              ? const Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.person))
                      : CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primary,
                          backgroundImage: NetworkImage(box.read('avatar')),
                          child: loginViewModel.uploadPicBTN
                              ? const Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                    ),
                                  ),
                                )
                              : null)),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                'Tap to Change profile picture',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.white),
              )
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
              Text(
                box.read('username'),
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.white),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const ViewNotificationScreen());
                },
                child: Icon(
                  Icons.notifications,
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
            length: 2,
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
                              child: Text("Account"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("WatchList"),
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
                      //Account Tab
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          children: [
                            mylistCard(box.read('username'), userIcon),
                            mylistCard(
                                box.read('phone') ?? '+234...', callIcon),
                            mylistCard(box.read('email'), emailIcon),
                            mylistCard('Settings', settingsIcon, ontap: () {
                              Get.to(() => const SettingsPage());
                            }),
                            mylistCard('Logout', logoutIcon, ontap: () {
                              showDialogWithFields();
                            }),
                            const SizedBox(
                              height: ySpace2,
                            ),
                            // CustomButton(
                            //     title: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Icon(
                            //           Icons.edit,
                            //           color: AppColors.white,
                            //           size: 15.w,
                            //         ),
                            //         SizedBox(
                            //           width: 10.w,
                            //         ),
                            //         Text(
                            //           'Edit Profile',
                            //           style: TextStyle(
                            //               fontSize: 13.sp,
                            //               color: AppColors.white),
                            //         ),
                            //       ],
                            //     ),
                            //     onclick: () {
                            //       Get.to(() => const EditProfilePage());
                            //     },
                            //     color: AppColors.primary,
                            //     borderColor: false)
                          ],
                        ),
                      ),

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

  Widget mylistCard(String title, String icon, {VoidCallback? ontap}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      horizontalTitleGap: 0,
      onTap: () {
        ontap!();
      },
      leading: SizedBox(
        height: 20,
        width: 20,
        child: SvgImage(asset: icon),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: TextStyle(fontSize: 14.sp, color: AppColors.white),
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
