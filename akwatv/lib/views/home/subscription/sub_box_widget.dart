import 'package:akwatv/providers/subscription_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubBoxWidget extends ConsumerWidget {
  final int selected;
  final String title;
  final String desc;
  final String amount;

  const SubBoxWidget(
      {Key? key,
      required this.selected,
      required this.amount,
      required this.desc,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var subViewModel = ref.watch(subScriptionProvider);
    return InkWell(
      onTap: () {
        subViewModel.changeIndex(selected);
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: subViewModel.selectedIndex == selected
                    ? AppColors.primary
                    : AppColors.termsTextColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.white, fontSize: 13),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "NGN $amount",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  " / month",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    ;
  }
}
