import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/utils/custom_drop_down.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/views/home/help/help_screen.dart';
import 'package:akwatv/views/home/profile/change_password.dart';
import 'package:akwatv/views/home/profile/edit_profile.dart';
import 'package:akwatv/views/home/settings/widgets/activity_cards.dart';
import 'package:akwatv/views/onboarding/forgot_password/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool notificationHandler = true;
  bool languageToggle = false;
  
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(homeViewModel);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'settings'.tr,
          style: const TextStyle(color: AppColors.white),
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
            ActivityCardWidget(
                onTap: () {
                  Get.to(() => const EditProfilePage());
                },
                title: 'editProfile'.tr,
                leadingIcon: Icons.person,
                isTrailing: false,
                isBody: false),

            const SizedBox(
              height: ySpace1,
            ),
            ActivityCardWidget(
                onTap: () {
                  Get.to(() => const ChangePasswordPage());
                },
                title: 'resetPassword'.tr,
                leadingIcon: Icons.visibility_off,
                isTrailing: false,
                isBody: false),

            const SizedBox(
              height: ySpace1,
            ),
            ActivityCardWidget(
                onTap: () {},
                title: 'notifications'.tr,
                leadingIcon: Icons.notifications,
                isTrailing: true,
                trailingIcon: Switch(
                    activeColor: AppColors.primary,
                    value: notificationHandler,
                    onChanged: (value) {
                      setState(() {
                        notificationHandler = value;
                      });
                    }),
                isBody: false),

            const SizedBox(
              height: ySpace1,
            ),
            // CustomDropDown(
            //   title: Row(
            //     children: const [
            //       Icon(
            //         Icons.timeline,
            //         color: AppColors.primary,
            //       ),
            //       SizedBox(
            //         width: 15,
            //       ),
            //       Text('Data usage', style: TextStyle(color: AppColors.white)),
            //     ],
            //   ),
            //   body: Column(
            //     children: [
            //       Card(
            //         color: AppColors.gray,
            //         child: ListTile(
            //           horizontalTitleGap: 0,
            //           onTap: () {
            //             videoDownload(context);
            //           },
            //           leading: const Padding(
            //             padding: EdgeInsets.symmetric(vertical: 8),
            //             child: Icon(
            //               Icons.subscriptions,
            //               color: AppColors.primary,
            //             ),
            //           ),
            //           title: const Text('Video download',
            //               style: TextStyle(
            //                   color: AppColors.white,
            //                   fontWeight: FontWeight.bold)),
            //           subtitle: const Text('Over Wi-fi only',
            //               style: TextStyle(color: AppColors.white)),
            //           trailing: const Icon(
            //             Icons.arrow_drop_down,
            //             color: AppColors.gray,
            //             size: 12,
            //           ),
            //         ),
            //       ),
            //       const SizedBox(
            //         height: ySpace1,
            //       ),
            //       Card(
            //         color: AppColors.gray,
            //         child: ListTile(
            //           horizontalTitleGap: 0,
            //           onTap: () {
            //             videoStream(context);
            //           },
            //           leading: const Padding(
            //             padding: EdgeInsets.symmetric(vertical: 8),
            //             child: Icon(
            //               Icons.subscriptions,
            //               color: AppColors.primary,
            //             ),
            //           ),
            //           title: const Text('Video streaming',
            //               style: TextStyle(
            //                   color: AppColors.white,
            //                   fontWeight: FontWeight.bold)),
            //           subtitle: const Text('Over Wi-fi only',
            //               style: TextStyle(color: AppColors.white)),
            //           trailing: const Icon(
            //             Icons.arrow_drop_down,
            //             color: AppColors.gray,
            //             size: 12,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: ySpace1,
            // ),

            ActivityCardWidget(
              onTap: () {
                setState(() {
                  languageToggle = !languageToggle;
                });
              },
              title: 'language'.tr,
              leadingIcon: Icons.language,
              isTrailing: false,
              isBody: languageToggle,
              body: SizedBox(
                height: 120,
                child: Column(
                  children: [
                    RadioListTile(
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      value: 1,
                      groupValue: viewModel.languageSelected,
                      title: const Text(
                        "English",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      onChanged: (newValue) {
                        var locale = const Locale('en_US');
                        Get.updateLocale(locale);
                        viewModel.changeLanguage(
                            lang: newValue, langCode: 'en_US');
                      },
                      activeColor: AppColors.primary,
                      selected: true,
                    ),
                    RadioListTile(
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      value: 2,
                      groupValue: viewModel.languageSelected,
                      title: const Text(
                        "French",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      onChanged: (newValue) {
                        var locale = const Locale('fr');
                        Get.updateLocale(locale);
                        viewModel.changeLanguage(
                            lang: newValue, langCode: 'fr');
                        // setState(() => viewModel.languageSelected = newValue);
                      },
                      activeColor: AppColors.primary,
                      selected: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: ySpace1,
            ),
            ActivityCardWidget(
                onTap: () {
                  Get.to(() => const HelpCenterPage());
                },
                title: 'help'.tr,
                leadingIcon: Icons.help_center,
                isTrailing: false,
                isBody: false),

            const SizedBox(
              height: ySpace1,
            ),
            ActivityCardWidget(
                onTap: () {
                  _launchURL();
                },
                title: 'aboutUs'.tr,
                leadingIcon: Icons.supervised_user_circle,
                isTrailing: false,
                isBody: false),

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

  _launchURL() async {
    const url = 'https://google.com';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  // //video download dialog
  // videoDownload(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder:
  //             (BuildContext context, void Function(void Function()) setState) {
  //           return AlertDialog(
  //             backgroundColor: AppColors.termsTextColor,
  //             title: const Text(
  //               "Video downloads",
  //               style: TextStyle(
  //                   color: AppColors.white,
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.w600),
  //             ),
  //             content: SizedBox(
  //               height: 130,
  //               child: Column(children: [
  //                 RadioListTile(
  //                   contentPadding: const EdgeInsets.all(0),
  //                   dense: true,
  //                   value: 1,
  //                   groupValue: _groupValue,
  //                   title: const Text(
  //                     "Over Wi-Fi only",
  //                     style: TextStyle(
  //                         color: AppColors.white,
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600),
  //                   ),
  //                   onChanged: (newValue) {
  //                     setState(() => _groupValue = newValue);
  //                   },
  //                   activeColor: AppColors.primary,
  //                   selected: true,
  //                 ),
  //                 const SizedBox(
  //                   height: ySpace1,
  //                 ),
  //                 RadioListTile(
  //                   contentPadding: const EdgeInsets.all(0),
  //                   dense: true,
  //                   value: 2,
  //                   groupValue: _groupValue,
  //                   title: const Text(
  //                     "Over Wi-Fi or Mobile Network",
  //                     style: TextStyle(
  //                         color: AppColors.white,
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600),
  //                   ),
  //                   onChanged: (newValue) {
  //                     setState(() => _groupValue = newValue);
  //                   },
  //                   activeColor: AppColors.primary,
  //                   selected: true,
  //                 ),
  //               ]),
  //             ),
  //             actions: [
  //               TextButton(
  //                 child: const Text(
  //                   "OK",
  //                   style: TextStyle(color: AppColors.primary, fontSize: 15),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               )
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // dynamic _stremValue = 0;
  // //video download dialog
  // videoStream(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder:
  //             (BuildContext context, void Function(void Function()) setState) {
  //           return AlertDialog(
  //             backgroundColor: AppColors.termsTextColor,
  //             title: const Text(
  //               "Video Streaming",
  //               style: TextStyle(
  //                   color: AppColors.white,
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.w600),
  //             ),
  //             content: SizedBox(
  //               height: 130,
  //               child: Column(children: [
  //                 RadioListTile(
  //                   contentPadding: const EdgeInsets.all(0),
  //                   dense: true,
  //                   value: 1,
  //                   groupValue: _stremValue,
  //                   title: const Text(
  //                     "Over Wi-Fi only",
  //                     style: TextStyle(
  //                         color: AppColors.white,
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600),
  //                   ),
  //                   onChanged: (newValue) {
  //                     setState(() => _stremValue = newValue);
  //                   },
  //                   activeColor: AppColors.primary,
  //                   selected: true,
  //                 ),
  //                 const SizedBox(
  //                   height: ySpace1,
  //                 ),
  //                 RadioListTile(
  //                   contentPadding: const EdgeInsets.all(0),
  //                   dense: true,
  //                   value: 2,
  //                   groupValue: _stremValue,
  //                   title: const Text(
  //                     "Over Wi-Fi or Mobile Network",
  //                     style: TextStyle(
  //                         color: AppColors.white,
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w600),
  //                   ),
  //                   onChanged: (newValue) {
  //                     setState(() => _stremValue = newValue);
  //                   },
  //                   activeColor: AppColors.primary,
  //                   selected: true,
  //                 ),
  //               ]),
  //             ),
  //             actions: [
  //               TextButton(
  //                 child: const Text(
  //                   "OK",
  //                   style: TextStyle(color: AppColors.primary, fontSize: 15),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               )
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

}
