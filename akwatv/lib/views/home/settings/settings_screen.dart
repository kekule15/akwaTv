import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/views/home/profile/change_password.dart';
import 'package:akwatv/views/home/profile/edit_profile.dart';
import 'package:akwatv/views/onboarding/forgot_password/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool notificationHandler = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Text(
          'Settings',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: generalHorizontalPadding),
        child: ListView(
          children: [
            const SizedBox(
              height: ySpace1,
            ),
            Card(
              color: AppColors.termsTextColor,
              child: ListTile(
                onTap: () {
                  Get.to(() => const EditProfilePage());
                },
                horizontalTitleGap: 0,
                leading: const Icon(
                  Icons.person,
                  color: AppColors.primary,
                ),
                title: const Text('Edit Profile',
                    style: TextStyle(color: AppColors.white)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.gray,
                  size: 12,
                ),
              ),
            ),
            const SizedBox(
              height: ySpace1,
            ),
            Card(
              color: AppColors.termsTextColor,
              child: ListTile(
                horizontalTitleGap: 0,
                onTap: () {
                  Get.to(() => const ChangePasswordPage());
                },
                leading: const Icon(
                  Icons.visibility_off,
                  color: AppColors.primary,
                ),
                title: const Text('Change Password',
                    style: TextStyle(color: AppColors.white)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.gray,
                  size: 12,
                ),
              ),
            ),
            const SizedBox(
              height: ySpace1,
            ),
            Card(
              color: AppColors.termsTextColor,
              child: ListTile(
                  horizontalTitleGap: 0,
                  //  contentPadding: EdgeInsets.all(0),
                  leading: const Icon(
                    Icons.notifications,
                    color: AppColors.primary,
                  ),
                  title: const Text('Notifications',
                      style: TextStyle(color: AppColors.white)),
                  trailing: Switch(
                      activeColor: AppColors.primary,
                      value: notificationHandler,
                      onChanged: (value) {
                        setState(() {
                          notificationHandler = value;
                        });
                      })),
            ),
            const SizedBox(
              height: ySpace1,
            ),
            const Card(
              color: AppColors.termsTextColor,
              child: ListTile(
                horizontalTitleGap: 0,
                //  contentPadding: EdgeInsets.all(0),
                leading: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Icon(
                    Icons.language,
                    color: AppColors.primary,
                  ),
                ),
                title: Text('App Language',
                    style: TextStyle(color: AppColors.white)),
                subtitle:
                    Text('English', style: TextStyle(color: AppColors.white)),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.gray,
                  size: 12,
                ),
              ),
            ),
            const SizedBox(
              height: ySpace1,
            ),
            const Card(
              color: AppColors.termsTextColor,
              child: ListTile(
                horizontalTitleGap: 0,
                //  contentPadding: EdgeInsets.all(0),
                leading: Icon(
                  Icons.supervised_user_circle,
                  color: AppColors.primary,
                ),
                title:
                    Text('About Us', style: TextStyle(color: AppColors.white)),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.gray,
                  size: 12,
                ),
              ),
            ),
            const SizedBox(
              height: ySpace1,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        elevation: 0,
        color: AppColors.black,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SizedBox(
            height: 20,
            child: Text('Akwa Tv 1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.gray)),
          ),
        ),
      ),
    );
  }
}
