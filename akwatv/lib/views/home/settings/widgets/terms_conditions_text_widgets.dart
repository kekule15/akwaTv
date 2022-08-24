import 'package:akwatv/styles/appColors.dart';
import 'package:flutter/material.dart';

Widget headerText({required String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
            color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 15,
      )
    ],
  );
}

Widget bodyText({required String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
            height: 1.5,
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300),
      ),
      const SizedBox(
        height: 15,
      )
    ],
  );
}
