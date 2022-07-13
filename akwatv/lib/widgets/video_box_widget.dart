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
      decoration: const BoxDecoration(
        color: AppColors.gray4,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        decoration: const BoxDecoration(color: AppColors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: ontap,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.termsTextColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                // image: DecorationImage(
                //     image: NetworkImage(img), fit: BoxFit.cover)),

                child: CachedNetworkImage(
                  imageUrl: img,
                  placeholder: (context, url) => const Center(
                    heightFactor: 2,
                    widthFactor: 2,
                    child: SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error), // This is what you need
                  fit: BoxFit.cover,
                ),
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
              height: 5,
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
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
