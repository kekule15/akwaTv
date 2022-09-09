import 'package:akwatv/providers/network_provider.dart';
import 'package:akwatv/providers/subscription_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/app_helpers.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/views/home/settings/terms_conditions.dart';
import 'package:akwatv/views/home/subscription/subscription_history.dart';
import 'package:akwatv/views/home/subscription/widgets/sub_box_widget.dart';
import 'package:akwatv/views/home/subscription/widgets/sub_dialogs.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class SubScriptionDetailsPage extends ConsumerStatefulWidget {
  const SubScriptionDetailsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubScriptionDetailsPageState();
}

class _SubScriptionDetailsPageState
    extends ConsumerState<SubScriptionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var subViewModel = ref.watch(subScriptionProvider);
    var data = subViewModel.subPlans();
    // final network = ref.watch(networkProvider);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.black,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'subscription'.tr,
            style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 23),
          )),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.gray4,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'currentPlan'.tr,
                        style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      Text(
                        LocalStorageManager.box.read('isSubActive') == true
                            ? 'active'.tr
                            : 'expire'.tr,
                        style: TextStyle(
                            color:
                                LocalStorageManager.box.read('isSubActive') ==
                                        true
                                    ? AppColors.green
                                    : AppColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    PreferenceUtils.getString(key: 'subName'),
                    style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.black),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        PreferenceUtils.getString(key: 'subName') == 'Premium'
                            ? "upgradePlanText2".tr
                            : 'upgradePlanText'.tr,
                        style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'amountPaid'.tr,
                            style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          Text(
                            'NGN ${PreferenceUtils.getString(key: 'subAmount')}',
                            style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'validity'.tr,
                            style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          Text(
                            (LocalStorageManager.box.read('expiredAt')),
                            style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'upgradePlan'.tr,
            style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SubBoxWidget(
                      upgrade: () {
                        confirmSubscriptionSheet(context,
                            name: subViewModel.subName,
                            amount: subViewModel.subAmount,
                            onTap: () => subViewModel.sendPaymentToPaystack(
                                context: context,
                                amount: subViewModel.subAmount));
                      },
                      isUpgrade: data[index]['name'] ==
                                  PreferenceUtils.getString(key: 'subName') &&
                              PreferenceUtils.getString(key: 'subName') ==
                                  'Free'
                          ? false
                          : data[index]['name'] ==
                                      PreferenceUtils.getString(
                                          key: 'subName') &&
                                  PreferenceUtils.getString(key: 'subName') !=
                                      'Free'
                              ? false
                              : true,
                      onTap: data[index]['onTap'],
                      selected: index,
                      amount: data[index]['amount'],
                      desc: data[index]['description'],
                      desc2: data[index]['description2'],
                      title: data[index]['name'],
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'agreePlan'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.white),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(() => const TermsAndConditions());
                },
              text: 'terms '.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'and '.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                TextSpan(
                  text: 'conditions'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(() => const TermsAndConditions());
                    },
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
        child: CustomButton(
          borderColor: false,
          color: AppColors.primary,
          onclick: () async {
            subViewModel.getPaymentHistoryService();
            Get.to(() => const SubscriptionPayHistory());
            //sendPaymentToPaystack(500);
          },
          title: Text(
            'paymentHistory'.tr,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
