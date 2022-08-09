import 'package:akwatv/styles/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeButton extends ConsumerWidget {
  final bool isLiked;
  final VoidCallback onTap;
  const LikeButton({Key? key, required this.isLiked, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        onTap: () => onTap(),
        child: CircleAvatar(
            radius: 13,
            backgroundColor: AppColors.white.withOpacity(0.2),
            child: Center(
              child: Icon(
                Icons.favorite,
                color: isLiked == false ? AppColors.white : AppColors.primary,
                size: 14,
              ),
            )));
  }
}
