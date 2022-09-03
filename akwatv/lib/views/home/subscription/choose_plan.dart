import 'package:akwatv/providers/subscription_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/app_helpers.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/views/home/settings/terms_conditions.dart';
import 'package:akwatv/views/home/subscription/widgets/sub_box_widget.dart';
import 'package:akwatv/views/home/subscription/widgets/sub_dialogs.dart';
import 'package:akwatv/views/home/subscription/congratulation_page.dart';
import 'package:akwatv/views/routes_args/congratulations_args.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_paystack_payment/flutter_paystack_payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChoosePlanPage extends ConsumerStatefulWidget {
  const ChoosePlanPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChoosePlanPageState();
}

class _ChoosePlanPageState extends ConsumerState<ChoosePlanPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    var subViewModel = ref.watch(subScriptionProvider);
    var data = subViewModel.subPlans();
    Future<bool> _onBackPressed() {
      return Future.delayed(Duration(seconds: 2));
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.black,
          centerTitle: true,
          title: Text(
            'choosePlan'.tr,
            style: const TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'planText'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.white, fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 30,
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
                        upgrade: () {},
                        isUpgrade: false,
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
          child: SizedBox(
            height: 150,
            child: Column(
              children: [
                CustomButton(
                  borderColor: true,
                  color: AppColors.termsTextColor,
                  onclick: () async {
                    // print(devicePlatformInfo.read('deviceId'));

                    Get.to(() => const CongratulationScreen(),
                        arguments: CongratulationsArgs(
                            payLater: false,
                            name: PreferenceUtils.getString(key: 'username'),
                            title: 'freeTrial'.tr,
                            subtitle: 'trialExpire'.tr,
                            date: LocalStorageManager.box.read('expiredAt')));
                  },
                  title: Text(
                    'payLater'.tr,
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  borderColor: false,
                  color: AppColors.primary,
                  onclick: () async {
                    confirmSubscriptionSheet(context,
                        name: subViewModel.subName,
                        amount: subViewModel.subAmount,
                        onTap: () => subViewModel.sendPaymentToPaystack(
                            context: context, amount: subViewModel.subAmount));
                  },
                  title: Text(
                    'subscribe'.tr,
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
