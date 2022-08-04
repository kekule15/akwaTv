import 'package:akwatv/providers/subscription_provider.dart';
import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/views/home/subscription/sub_box_widget.dart';
import 'package:akwatv/views/onboarding/congratulation_page.dart';
import 'package:akwatv/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_paystack_payment/flutter_paystack_payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ChoosePlanPage extends ConsumerStatefulWidget {
  const ChoosePlanPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChoosePlanPageState();
}

class _ChoosePlanPageState extends ConsumerState<ChoosePlanPage> {
  final plugin = PaystackPayment();

  @override
  void initState() {
    plugin.initialize(publicKey: payStackAPIKey);
    super.initState();
  }

  void sendPaymentToPaystack(
    double amount,
  ) async {
    // paystackPlugin.initialize(publicKey: AppKeys.paystackPublicKey);

    Charge charge = Charge()
      // Convert to kobo and round to the nearest whole number
      ..amount = (amount * 100).round()
      ..email = 'rbsnation111@gmail.com'
      ..card = _getCardFromUI()
      ..reference = _getReference();
    var checkout =
        plugin.checkout(context, charge: charge, method: CheckoutMethod.card);
    var response = await checkout;
    print("checkout res $response");

    if (response.status == true) {
      print('Paystack response =========== ${response.toString()}');
    } else {}
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: '43178349848491',
      cvc: '344',
      expiryMonth: '23',
      expiryYear: '22',
    );

    // Using Cascade notation (similar to Java's builder pattern)
//    return PaymentCard(
//        number: cardNumber,
//        cvc: cvv,
//        expiryMonth: expiryMonth,
//        expiryYear: expiryYear)
//      ..name = 'Segun Chukwuma Adamu'
//      ..country = 'Nigeria'
//      ..addressLine1 = 'Ikeja, Lagos'
//      ..addressPostalCode = '100001';

    // Using optional parameters
//    return PaymentCard(
//        number: cardNumber,
//        cvc: cvv,
//        expiryMonth: expiryMonth,
//        expiryYear: expiryYear,
//        name: 'Ismail Adebola Emeka',
//        addressCountry: 'Nigeria',
//        addressLine1: '90, Nnebisi Road, Asaba, Deleta State');
  }

  String _getReference() {
    String platform;
    if (!kIsWeb) {
      if (Platform.isIOS) {
        platform = 'iOS';
      } else {
        platform = 'Android';
      }
    } else {
      platform = "WEB";
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
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
          title: const Text(
            'Choose Plan',
            style: TextStyle(
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Subscribe for a Plan to enjoy Akwa Amaka Tv Shows',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white, fontSize: 17),
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
                        selected: index,
                        amount: data[index]['amount'],
                        desc: data[index]['description'],
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
          child: SizedBox(
            height: 150,
            child: Column(
              children: [
                CustomButton(
                  borderColor: true,
                  color: AppColors.termsTextColor,
                  onclick: () async {
                    Get.to(() => const CongratulationScreen());
                  },
                  title: const Text(
                    'Pay Later',
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  borderColor: false,
                  color: AppColors.primary,
                  onclick: () async {
                    sendPaymentToPaystack(500);
                  },
                  title: 2 == 3
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : const Text(
                          'Subscribe',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 16),
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
