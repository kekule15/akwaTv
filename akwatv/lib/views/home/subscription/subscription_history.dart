import 'package:akwatv/providers/network_provider.dart';
import 'package:akwatv/providers/subscription_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/app_helpers.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/svgs.dart';
import 'package:akwatv/widgets/network_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class SubscriptionPayHistory extends ConsumerWidget {
  const SubscriptionPayHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var subViewModel = ref.watch(subScriptionProvider);
    var data = subViewModel.payHistoryData.data;
   // final network = ref.watch(networkProvider);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.black,
          title: Text(
            'paymentHistory'.tr,
            style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 23),
          ),
        ),
        body: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'paymentHistoryText'.tr,
                    style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  subViewModel.payLoader
                      ? const Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : data!.data!.isEmpty == true
                          ? Center(
                              child: Column(
                                children: const [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  // SvgImage(
                                  //   asset: emptyVid,
                                  //   height: 200,
                                  //   width: 200,
                                  // ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'No Data Fetched',
                                    style: TextStyle(
                                        color: AppColors.white, fontSize: 17),
                                  )
                                ],
                              ),
                            )
                          : Column(
                              children: List.generate(
                                  data.data!.length,
                                  (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.gray4,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              'You Subscribed for a ${data.data![index].name} Plan',
                                              style: const TextStyle(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17),
                                            ),
                                            subtitle: Text(
                                              'NGN ${data.data![index].amount}',
                                              style: const TextStyle(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                            trailing: Text(
                                              formatter.format(data
                                                  .data![index].timestamps!),
                                              style: const TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      )),
                            )
                ],
              )
           );
  }
}
