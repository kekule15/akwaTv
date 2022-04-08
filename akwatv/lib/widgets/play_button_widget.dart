import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget PlayButtonWidget({required Widget icon}) {
  return Container(
    height: 20.w,
    width: 20.w,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: AppColors.white)),
    child: Center(
      child: icon
    ),
  );
}
