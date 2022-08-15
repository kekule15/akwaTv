import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/widgets/image_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class CallAdminPage extends ConsumerWidget {
  const CallAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Text(
          'Call Center ',
          style: TextStyle(color: AppColors.white, fontSize: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Emmergency Call Center ',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          const SvgImage(
            asset: callAdminIcon,
            height: 150,
            width: 150,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "He, let's help you today",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Phone lines are available between 8:00 AM and 5:00 PM on Weekdays",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.white, fontSize: 14),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Tap the number to call",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.white, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              launchUrl(Uri.parse("tel:+234 9014700476"));
            },
            child: const Text(
              '+234 9014700476',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.white, fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
