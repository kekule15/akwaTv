import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/images.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/home/coming_soon/coming_soon-video_card.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComingSoonPage extends ConsumerStatefulWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends ConsumerState<ComingSoonPage> {
  List<String> comingSoonVideos = [
    'Omo Gheto',
    'Boko & Bena',
    'Red Handed',
    'Bad Child',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Text(
              'Coming Soon',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17.sp, color: AppColors.white),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Column(
            children: List.generate(
                comingSoonVideos.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ComingSoonCard(
                          title: comingSoonVideos[index],
                          playButton: playButtonWidget(
                            icon: Icon(
                              Icons.play_arrow,
                              color: AppColors.white,
                              size: 20.w,
                            ),
                          )),
                    )),
          )
        ],
      ),
    );
  }
}
