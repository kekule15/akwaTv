import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/widgets/image_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget networkWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        const SvgImage(
          asset: connection,
          height: 200,
          width: 200,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          'networkText'.tr,
          style: const TextStyle(color: AppColors.white, fontSize: 17),
        )
      ],
    ),
  );
}
