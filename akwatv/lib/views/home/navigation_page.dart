import 'package:akwatv/providers/navigators.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/views/home/coming_soon/coming_soon.dart';
import 'package:akwatv/views/home/downloads/downloads_view.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/home/home_view/home_view.dart';
import 'package:akwatv/views/home/notifications/notification_screen.dart';
import 'package:akwatv/views/home/profile/profile_view.dart';
import 'package:akwatv/views/home/search/search_screen.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeNavigation extends ConsumerStatefulWidget {
  const HomeNavigation({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeNavigation();
}

class _HomeNavigation extends ConsumerState<HomeNavigation> {


  @override
  Widget build(BuildContext context) {
    final _viewModel = ref.watch(homeViewModel);
    // final user = _viewModel.user.data;
    Future<bool> _onBackPressed() {
      return Future.delayed(const Duration(seconds: 2));
    }

  

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
        body: _pages.elementAt(ref.watch(homeViewModel).selectedIndex),
        drawer: const MyDrawerPage(),
        bottomNavigationBar: Theme(
          data: Theme.of(context),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              color: AppColors.primary,
            ),
            unselectedLabelStyle: const TextStyle(color: AppColors.gray),
            unselectedItemColor: AppColors.gray,
            backgroundColor: AppColors.black,
            showSelectedLabels: true,
            selectedItemColor: AppColors.primary,
            currentIndex: ref.watch(homeViewModel).selectedIndex,
            onTap: _viewModel.changeIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: ref.watch(homeViewModel).selectedIndex == 0
                    ? const Icon(Icons.home)
                    : const Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: ref.watch(homeViewModel).selectedIndex == 1
                    ? const Icon(Icons.search)
                    : const Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: ref.watch(homeViewModel).selectedIndex == 2
                    ? const Icon(Icons.notifications)
                    : const Icon(Icons.notifications),
                label: "Notifications",
              ),
              // BottomNavigationBarItem(
              //   backgroundColor: Colors.white,
              //   icon: ref.watch(homeViewModel).selectedIndex == 3
              //       ? Icon(Icons.ondemand_video)
              //       : Icon(Icons.ondemand_video),
              //   label: "ComingSoon",
              // ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: ref.watch(homeViewModel).selectedIndex == 3
                    ? const Icon(Icons.person)
                    : const Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(),
    ViewNotificationScreen(),
    //DownLoadsPage(),
    // ComingSoonPage(),
    ProfilePage()
  ];
}
