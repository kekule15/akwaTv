import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/views/home/help/call_admin.dart';
import 'package:akwatv/views/home/settings/widgets/activity_cards.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterPage extends ConsumerWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(
          'helpCenter'.tr,
          style: const TextStyle(color: AppColors.white),
        ),
      ),
      backgroundColor: AppColors.black,
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            "hereToHelp".tr,
            style: const TextStyle(color: AppColors.white, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          ActivityCardWidget(
              onTap: () {
                Get.to(() => const CallAdminPage());
              },
              title: 'callUs'.tr,
              leadingIcon: Icons.call,
              isTrailing: false,
              isBody: false),
          const SizedBox(
            height: ySpace2,
          ),
          ActivityCardWidget(
              onTap: () {
                launchEmailSubmission();
                //Get.to(() => const HelpCenterPage());
              },
              title: 'sendEmail'.tr,
              leadingIcon: Icons.email,
              isTrailing: false,
              isBody: false),
          const SizedBox(
            height: ySpace2,
          ),
          ActivityCardWidget(
              onTap: () {
                Get.to(() => const HelpCenterPage());
              },
              title: 'termsAndCondition'.tr,
              leadingIcon: Icons.help_center,
              isTrailing: false,
              isBody: false),
          const SizedBox(
            height: ySpace2,
          ),
        ],
      ),
    );
  }

  void launchEmailSubmission() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'augustusonyekachi111@gmail.com',
        query: 'subject=Message&body= I have a complaint');
    String url = params.toString();
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // print('Could not launch $url');
    }
  }
}
