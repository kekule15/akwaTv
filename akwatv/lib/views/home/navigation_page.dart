import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/views/home/coming_soon/coming_soon.dart';
import 'package:akwatv/views/home/downloads/downloads_view.dart';
import 'package:akwatv/views/home/home_view/drawer.dart';
import 'package:akwatv/views/home/home_view/home_view.dart';
import 'package:akwatv/views/home/profile/profile_view.dart';
import 'package:akwatv/views/home/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoard extends StatefulWidget {
  final int? currentPage;

  const DashBoard({Key? key, required this.currentPage}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int tapCounter = 0;
  bool tapped = false;
  ValueNotifier<int>? currentPage;
  int? _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentPage;
  }

  Future<bool> _onBackPressed() {
    return Future.delayed(Duration(seconds: 2));
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openMyDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawerPage(),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(
              color: AppColors.primary,
            ),
            unselectedLabelStyle: TextStyle(color: AppColors.gray),
            onTap: onTabTapped,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex!,
            unselectedItemColor: AppColors.gray,
            backgroundColor: AppColors.black,
            showSelectedLabels: true,
            selectedItemColor: AppColors.primary,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: _currentIndex == 0 ? Icon(Icons.home) : Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: _currentIndex == 1
                    ? Icon(Icons.search)
                    : Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: _currentIndex == 2
                    ? Icon(Icons.download_for_offline)
                    : Icon(Icons.download_for_offline),
                label: "Downloads",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: _currentIndex == 3
                    ? Icon(Icons.ondemand_video)
                    : Icon(Icons.ondemand_video),
                label: "ComingSoon",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: _currentIndex == 3
                    ? Icon(Icons.person)
                    : Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: _children[_currentIndex!]),
    );
  }

  int? selected;
  String? name;
  String? email;
  String? phone;
  String? location;
  final List<Widget> _children = [
    const HomePage(),
    const SearchPage(),
    const DownLoadsPage(),
    const ComingSoonPage(),
    const ProfilePage()
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      selected = _currentIndex;
    });
  }
}
