import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/app_helpers.dart';
import 'package:akwatv/utils/constvalues.dart';
import 'package:akwatv/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoBoxWidget extends ConsumerWidget {
  final VoidCallback ontap;
  final String img;
  final String title;
  final String description;
  const VideoBoxWidget(
      {Key? key,
      required this.ontap,
      required this.img,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 290,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.gray4.withOpacity(0.3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: ontap,
            child: Container(
              height: 220,
              width: 1800,
              decoration: BoxDecoration(
                  color: AppColors.termsTextColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage(img), fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        title,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // const LikeButton()
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    description,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.white,
                        fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalVideoBoxWidget extends ConsumerWidget {
  final VoidCallback ontap;
  final String img;
  final String title;
  const HorizontalVideoBoxWidget({
    Key? key,
    required this.ontap,
    required this.img,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            height: 180,
            width: 120,
            decoration: BoxDecoration(
                color: AppColors.termsTextColor,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(img), fit: BoxFit.cover)),
          ),
        ),
        const SizedBox(
          height: ySpaceMin,
        ),
        SizedBox(
          width: 150,
          child: Text(
            title,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.white,
                fontSize: 12),
          ),
        ),
      ],
    );
  }
}
