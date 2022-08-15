import 'package:akwatv/styles/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityCardWidget extends ConsumerWidget {
  final VoidCallback onTap;
  final String title;
  final IconData leadingIcon;
  final Widget? trailingIcon;
  final bool isTrailing;
  final Widget? body;
  final bool isBody;
  const ActivityCardWidget(
      {required this.onTap,
      required this.title,
      required this.leadingIcon,
       this.trailingIcon,
      required this.isTrailing,
       this.body,
      required this.isBody,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: AppColors.gray4,
      child: Column(
        children: [
          ListTile(
            onTap: () => onTap(),
            horizontalTitleGap: 0,
            leading: Icon(
              leadingIcon,
              color: AppColors.primary,
            ),
            title: Text(title, style: const TextStyle(color: AppColors.white)),
            trailing: isTrailing == false
                ? const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.gray,
                    size: 12,
                  )
                : trailingIcon,
          ),
          isBody == false
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    child: body,
                  ),
                )
        ],
      ),
    );
  }
}
