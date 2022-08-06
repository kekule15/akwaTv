import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscriptionPayHistory extends ConsumerWidget {
  const SubscriptionPayHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        title: const Text(
          'Payment History',
          style: TextStyle(
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
          const Text(
            'Your Subscription payment history',
            style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: List.generate(
                4,
                (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.gray4,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const ListTile(
                          title: Text(
                            'You Subscribed for a Regular Plan',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                          subtitle: Text(
                            'NGN 500.00',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          trailing: Text(
                            'Aug-10-2022',
                            style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
