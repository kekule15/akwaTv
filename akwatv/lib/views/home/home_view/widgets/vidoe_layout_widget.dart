import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/widgets/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoLayoutWidget extends ConsumerWidget {
  final String title;
  final String img;
  final String subtitle;
  final VoidCallback onTap;
  final IconData icon;
  final VoidCallback iconTap;
  final Color iconColor;
  const VideoLayoutWidget(
      {required this.title,
      required this.img,
      required this.subtitle,
      required this.onTap,
      required this.icon,
      required this.iconTap,
      required this.iconColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: () => onTap(),
        child: Card(
          color: AppColors.termsTextColor,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(img), fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              color: AppColors.white, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            subtitle,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.white,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: InkWell(
                    onTap: () => iconTap(),
                    child: playButtonWidget(
                      icon: Icon(
                        icon,
                        color: iconColor,
                        size: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
