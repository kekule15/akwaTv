import 'package:akwatv/providers/subscription_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubBoxWidget extends ConsumerWidget {
  final int selected;
  final String title;
  final String desc;
  final String desc2;
  final String amount;
  final VoidCallback onTap;
  final bool isUpgrade;
  final VoidCallback upgrade;

  const SubBoxWidget({
    Key? key,
    required this.selected,
    required this.amount,
    required this.desc,
    required this.desc2,
    required this.onTap,
    required this.title,
    required this.isUpgrade,
    required this.upgrade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var subViewModel = ref.watch(subScriptionProvider);
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 200,
        width: 170,
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
            Text(
              desc2,
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
            const SizedBox(
              height: 20,
            ),
            isUpgrade == false
                ? const SizedBox()
                : InkWell(
                    onTap: () => upgrade(),
                    child: Container(
                      width: 130,
                      decoration: BoxDecoration(
                        color: AppColors.gray4,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Upgrade",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.white,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );

    ;
  }
}
