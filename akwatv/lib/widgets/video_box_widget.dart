import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/app_helpers.dart';
import 'package:akwatv/utils/constvalues.dart';
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
      width: 180,
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
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(img), fit: BoxFit.cover)),
              // image: DecorationImage(
              //     image: NetworkImage(img), fit: BoxFit.cover)),

              // child: CachedNetworkImage(
              //   imageUrl: img,
              //   placeholder: (context, url) => const Center(
              //     heightFactor: 2,
              //     widthFactor: 2,
              //     child: SizedBox(
              //       height: 16,
              //       width: 16,
              //       child: CircularProgressIndicator(
              //         strokeWidth: 1.5,
              //         valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              //       ),
              //     ),
              //   ),
              //   errorWidget: (context, url, error) =>
              //       const Icon(Icons.error), // This is what you need
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          const SizedBox(
            height: ySpaceMin,
          ),
          Text(
            title,
            style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            child: Text(
              description,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.white,
                  fontSize: 10),
            ),
          ),
          const SizedBox(
            height: 10,
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
