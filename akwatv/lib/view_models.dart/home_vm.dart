import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/temporary_storage.dart';
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
  int languageSelected = 1;
  HomeViewModel(Reader read) : super(read) {
    subDrawerList();

    _loadFromPrefs();
  }

  List<Map<String, dynamic>> subDrawerList() {
    return [
      {
        'title': "settings".tr,
        "icon": Icons.settings,
        "onTap": () {
          Get.to(() => const SettingsPage());
        }
      },
      {
        'title': "subscription".tr,
        "icon": Icons.subscriptions,
        "onTap": () {
          Get.to(() => const SubScriptionDetailsPage());
        }
      },
      {
        'title': "account".tr,
        "icon": Icons.person,
        "onTap": () {
          Get.back();

          changeIndex(3);
        }
      },
      {
        'title': "help".tr,
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
        'title': "profile".tr,
        "icon": Icons.person,
        "onTap": () {
          Get.to(() => const EditProfilePage());
        }
      },
      {
        'title': "subscription".tr,
        "icon": Icons.subscriptions,
        "onTap": () {
          Get.to(() => const SubScriptionDetailsPage());
        }
      },
      {
        'title': "help".tr,
        "icon": Icons.help_center,
        "onTap": () {
          Get.to(() => const HelpCenterPage());
        }
      },
      {
        'title': "settings".tr,
        "icon": Icons.settings,
        "onTap": () {
          Get.to(() => const SettingsPage());
        }
      },
    ];
  }

  // change language

  String languageCode = 'en_US';

  changeLanguage({required dynamic lang, required String langCode}) {
    languageSelected = lang;
    _saveToPrefs(code: langCode, selectd: languageSelected);
    notifyListeners();
  }

  _loadFromPrefs() async {
    languageCode = PreferenceUtils.getString(key: languageCode);
    languageSelected = PreferenceUtils.getInt(key: 'languageSelected');

    notifyListeners();
  }

  _saveToPrefs({required dynamic code, required int selectd}) async {
    PreferenceUtils.setInt(key: 'languageSelected', value: selectd);
    PreferenceUtils.setString(key: languageCode, value: code);
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
