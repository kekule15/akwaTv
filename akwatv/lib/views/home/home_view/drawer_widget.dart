import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:flutter/material.dart';

Widget drawerWidget(
    {required VoidCallback onTap,
    required dynamic title,
    required IconData icon,
    required Color iconColor,
    required Color titleColor}) {
  return InkWell(
    onTap: () {
     
      onTap();
    },
    child: Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: TextStyle(color: titleColor, fontSize: 18),
        ),
      ],
    ),
  );
}
