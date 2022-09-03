import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/providers/network_provider.dart';
import 'package:akwatv/providers/video_controller_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/home/home_view/drawer_widget.dart';
import 'package:akwatv/views/home/home_view/video_details.dart';
import 'package:akwatv/views/home/home_view/video_screen.dart';
import 'package:akwatv/views/home/home_view/watchlist_page.dart';
import 'package:akwatv/views/home/home_view/widgets/vidoe_layout_widget.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/widgets/network_widget.dart';
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
  //List<Datum> watchListVideoData = [];
  @override
  void didChangeDependencies() {
   // getWatchList();
    super.didChangeDependencies();
  }

  // getWatchList() async {
  //   final videoProvider = ref.watch(videoViewModel);
  //   var videoData = videoProvider.listVideoData.data;
  //   var watchList = videoProvider.getWatchListData.data!.data;

  //   for (var data in videoData!.data!
  //       .where((element) => watchList!.contains(element.id))) {
  //     watchListVideoData.add(data);
  //   }
  // }

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
    final loginViewModel = ref.watch(viewModel);
    final _viewModel = ref.watch(homeViewModel);
    var data = _viewModel.profileList();
    final network = ref.watch(networkProvider);
    var videoCon = ref.watch(videoControllerProvider);
    final videoProvider = ref.watch(videoViewModel);

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
              PreferenceUtils.getString(key: 'avatar') != ''
                  ? CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      backgroundImage: NetworkImage(
                          PreferenceUtils.getString(key: 'avatar')),
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person),
                    ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                PreferenceUtils.getString(key: 'username'),
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
              InkWell(
                onTap: () {
                  _viewModel.changeIndex(2);
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
        network.isCheck == true
            ? Padding(
                padding: const EdgeInsets.only(top: 300),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TabBar(
                              unselectedLabelColor: Colors.grey,
                              indicatorSize: TabBarIndicatorSize.label,
                              labelColor: AppColors.white,
                              indicator: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: AppColors.primary)),
                              ),
                              tabs: [
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("account".tr),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("watchlist".tr),
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
                            ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        data.length,
                                        (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 30),
                                            child: drawerWidget(
                                                onTap: data[index]["onTap"],
                                                title: data[index]['title'],
                                                icon: data[index]['icon'],
                                                iconColor: AppColors.white,
                                                titleColor: AppColors.white)),
                                      )),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 20),
                                    child: drawerWidget(
                                        onTap: () {
                                          showDialogWithFields();
                                        },
                                        title: 'Logout',
                                        icon: Icons.logout,
                                        iconColor: AppColors.primary,
                                        titleColor: AppColors.primary)),
                              ],
                            ),

                            //Favourite Tab
                            MediaQuery.removePadding(
                              context: context,
                              removeRight: false,
                              removeTop: true,
                              removeLeft: false,
                              child: ListView(
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Your Favourites',
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (videoProvider.watchListVideoData.isEmpty !=
                                              true) {
                                            Get.to(
                                                () => const ViewAllWatchList(),
                                                arguments: videoProvider.watchListVideoData);
                                          } else {}
                                        },
                                        child: const Text(
                                          'View All',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  videoProvider.watchListVideoData.isEmpty == true
                                      ? Center(
                                          child: Column(
                                            children: [
                                              // const SvgImage(
                                              //   asset: emptyVid,
                                              //   height: 200,
                                              //   width: 200,
                                              // ),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              Text(
                                                'noMovieFetched'.tr,
                                                style: const TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 17),
                                              )
                                            ],
                                          ),
                                        )
                                      : Column(
                                          children: List.generate(
                                             videoProvider.watchListVideoData.length,
                                              (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: VideoLayoutWidget(
                                                      title: videoProvider.watchListVideoData[
                                                              index]
                                                          .title!,
                                                      img: videoProvider.watchListVideoData[
                                                              index]
                                                          .img!,
                                                      subtitle:
                                                          videoProvider.watchListVideoData[
                                                                  index]
                                                              .desc!,
                                                      onTap: () {
                                                        videoCon.initPlayer(
                                                          link:
                                                              videoProvider.watchListVideoData[
                                                                      index]
                                                                  .video!,
                                                          description:
                                                              videoProvider.watchListVideoData[
                                                                      index]
                                                                  .desc!,
                                                          title:
                                                              videoProvider.watchListVideoData[
                                                                      index]
                                                                  .title!,
                                                          movieId:
                                                              videoProvider.watchListVideoData[
                                                                      index]
                                                                  .id,
                                                        );
                                                        videoCon.sortSimilarVideos(
                                                            data:
                                                                videoProvider.watchListVideoData[
                                                                    index]);
                                                        Get.to(() => VideoScreen(
                                                            url:
                                                                videoProvider.watchListVideoData[
                                                                        index]
                                                                    .video!));
                                                       
                                                      },
                                                      icon: Icons.close,
                                                      iconTap: () {
                                                        deleteWatchList(
                                                          data:
                                                              videoProvider.watchListVideoData[
                                                                  index],
                                                          movieID:
                                                              videoProvider.watchListVideoData[
                                                                      index]
                                                                  .id,
                                                        );
                                                      },
                                                      iconColor:
                                                          AppColors.primary))),
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
              )
            : networkWidget(),
      ]),
    );
  }

  Widget mylistCard(String title, IconData icon, {VoidCallback? ontap}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      horizontalTitleGap: 0,
      onTap: () {
        ontap!();
      },
      leading: Icon(
        icon,
        size: 20,
        color: AppColors.white,
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

  void deleteWatchList({required dynamic movieID, required dynamic data}) {
    final videoProvider = ref.watch(videoViewModel);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Delete Item',
            textAlign: TextAlign.center,
          ),
          content: videoProvider.deleteTOListBTN
              ? SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                )
              : const Text(
                  'Sure you want to delete this saved Watchlist?',
                  textAlign: TextAlign.center,
                ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No', style: TextStyle(color: AppColors.gray)),
            ),
            TextButton(
              onPressed: () async {
                videoProvider.deleteWatchListservice(movieID: movieID);
                videoProvider.watchListVideoData.remove(data);

                Future.delayed(const Duration(seconds: 1), () {
                  videoProvider.getAllWatchList();
                  //getWatchList();
                  Get.back();
                });
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }
}
