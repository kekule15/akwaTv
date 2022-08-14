import 'package:akwatv/providers/subscription_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/app_helpers.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/views/home/subscription/congratulation_page.dart';
import 'package:akwatv/views/home/subscription/subscription_history.dart';
import 'package:akwatv/views/home/subscription/widgets/sub_box_widget.dart';
import 'package:akwatv/views/home/subscription/widgets/sub_dialogs.dart';
import 'package:akwatv/views/routes_args/congratulations_args.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_paystack_payment/flutter_paystack_payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
   

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.black,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Subscription',
            style: TextStyle(
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
                      const Text(
                        'Current Plan',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      Text(PreferenceUtils.getBool(key: 'isSubActive')
                         == true ? 'Active' : 'Expired',
                        style: TextStyle(
                            color:  PreferenceUtils.getBool(key: 'isSubActive') == true
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.black),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Upgrade now and enjoy awesome features on Akwa Amaka TV',
                        style: TextStyle(
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
                          const Text(
                            'Amount Paid',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          Text(
                            'NGN ${  PreferenceUtils.getString(key: 'subAmount')}',
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
                          const Text(
                            'Validity',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          Text(
                           formatter.parse(PreferenceUtils.getString(key: 'expiredAt')).toString(),
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
          const Text(
            'Upgrade Plan',
            style: TextStyle(
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
                      isUpgrade: data[index]['name'] ==   PreferenceUtils.getString(key: 'subName') &&
                                PreferenceUtils.getString(key: 'subName') == 'Free'
                          ? false
                          : data[index]['name'] ==   PreferenceUtils.getString(key: 'subName') &&
                                   PreferenceUtils.getString(key: 'subName') != 'Free'
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
          const Text(
            'By Subscribing to Akwa Amaka TV you agree to our',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.white),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Get.to(const CreateAccountScreen());
                },
              text: 'terms ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: 'and ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                TextSpan(
                  text: 'Conditions',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Get.to(const CreateAccountScreen());
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
            Get.to(() => const SubscriptionPayHistory());
            //sendPaymentToPaystack(500);
          },
          title: const Text(
            'Payment History',
            style: TextStyle(color: AppColors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
