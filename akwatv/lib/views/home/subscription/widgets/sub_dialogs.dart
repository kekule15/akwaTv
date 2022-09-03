import 'package:akwatv/providers/subscription_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/views/home/subscription/subscription_details.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:akwatv/widgets/dialog_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

confirmSubscriptionSheet(BuildContext context,
    {required String name,
    required dynamic amount,
    required VoidCallback onTap}) async {
  Widget data = Consumer(builder: (context, ref, child) {
    var subViewModel = ref.watch(subScriptionProvider);

    return Column(
      children: [
        const Text(
          'Confirm Subscription',
          style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.gray4, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Subscription Plan',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  name,
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Subscription Amount',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  'NGN $amount',
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Subscription Validity',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
                const Text(
                  '1 Month',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        CustomButton(
          borderColor: false,
          color: AppColors.primary,
          onclick: () async {
            //Navigator.pop(context);
            onTap();
          },
          title: subViewModel.saveData
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                )
              : const Text(
                  'Continue',
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
        ),
      ],
    );
  });
  return DialogWidgets.modalBottomSheetMenu(context, data,
      height: 600, dismiss: false);
}

checkPaymentStatus(BuildContext context, {required VoidCallback onTap}) async {
  Widget data = Consumer(builder: (context, ref, child) {
    return Column(
      children: [
        const Text(
          'Payment Successful',
          style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 60,
        ),
        const Text(
          'You have successfully Subscribed to Akwa Amaka TV Shows',
          style: TextStyle(
              color: AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 50,
        ),
        const SvgImage(
          asset: successLogo,
          height: 100,
          width: 100,
        ),
        const SizedBox(
          height: 100,
        ),
        CustomButton(
          borderColor: false,
          color: AppColors.primary,
          onclick: () async {
            Navigator.pop(context);
            onTap();
          },
          title: const Text(
            'Continue',
            style: TextStyle(color: AppColors.white, fontSize: 16),
          ),
        ),
      ],
    );
  });
  return DialogWidgets.modalBottomSheetMenu(context, data,
      height: 500, dismiss: false, showCancelButton: false);
}

checkSubscriptionStatus(
  BuildContext context,
) async {
  Widget data = Consumer(builder: (context, ref, child) {
    // var subViewModel = ref.watch(subScriptionProvider);

    return Column(
      children: [
        Text(
          'planExpired'.tr,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 60,
        ),
        Text(
          'planExpiredText'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 60,
        ),
        CustomButton(
          borderColor: false,
          color: AppColors.primary,
          onclick: () async {
            Get.to(() => const SubScriptionDetailsPage());
          },
          title: Text(
            'subscribe'.tr,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
          ),
        ),
      ],
    );
  });
  return DialogWidgets.modalBottomSheetMenu(context, data,
      height: 400, dismiss: true);
}
