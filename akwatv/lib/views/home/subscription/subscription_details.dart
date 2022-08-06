import 'package:akwatv/providers/subscription_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/views/home/subscription/subscription_history.dart';
import 'package:akwatv/views/home/subscription/widgets/sub_box_widget.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class SubScriptionDetailsPage extends ConsumerWidget {
  const SubScriptionDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    children: const [
                      Text(
                        'Current Plan',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      Text(
                        'Active',
                        style: TextStyle(
                            color: AppColors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Regular',
                    style: TextStyle(
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
                        children: const [
                          Text(
                            'Amount Paid',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          Text(
                            'NGN 500',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'Validity',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          Text(
                            'Sept-10-2022',
                            style: TextStyle(
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
                      upgrade: () {},
                      isUpgrade:
                          data[index]['name'] == 'Regular' ? false : true,
                      onTap: data[index]['onTap'],
                      selected: index,
                      amount: data[index]['amount'],
                      desc: data[index]['description'],
                      title: data[index]['name'],
                    ),
                  );
                }),
          )
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
