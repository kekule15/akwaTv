import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/home/help/help_screen.dart';
import 'package:akwatv/views/home/profile/edit_profile.dart';
import 'package:akwatv/views/home/settings/settings_screen.dart';
import 'package:akwatv/views/home/subscription/subscription_details.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class HomeViewModel extends BaseViewModel {
  int selectedIndex = 0;
  HomeViewModel(Reader read) : super(read) {
    subDrawerList();
  }

  List<Map<String, dynamic>> subDrawerList() {
    return [
      {
        'title': "Settings",
        "icon": Icons.settings,
        "onTap": () {
          Get.to(() => const SettingsPage());
        }
      },
      {
        'title': "Subscription",
        "icon": Icons.subscriptions,
        "onTap": () {
          Get.to(() => const SubScriptionDetailsPage());
        }
      },
      {
        'title': "Account",
        "icon": Icons.person,
        "onTap": () {
          Get.back();

          changeIndex(3);
        }
      },
      {
        'title': "Help",
        "icon": Icons.live_help,
        "onTap": () {
          Get.to(() => const HelpCenterPage());
        }
      }
    ];
  }
    List<Map<String, dynamic>> profileList() {
    return [
      {
        'title': "Profile",
        "icon": Icons.person,
        "onTap": () {
          Get.to(() => const EditProfilePage());
        }
      },
      {
        'title': "Subscription",
        "icon": Icons.subscriptions,
        "onTap": () {
          Get.to(() => const SubScriptionDetailsPage());
        }
      },
      {
        'title': "Settings",
        "icon": Icons.settings,
        "onTap": () {
          Get.to(() => const SettingsPage());
        }
      },
      
    ];
  }

  void changeIndex(int index) async {
    // if (index == 3) {
    //   await read(videoViewModel).getAllWatchList();
    // }
    if (index == 0) {
      await read(videoViewModel).getCategoryList();
    }
    selectedIndex = index;
    notifyListeners();
  }
}
