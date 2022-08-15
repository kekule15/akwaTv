import 'package:akwatv/models/future_manager.dart';
import 'package:akwatv/models/payment_history_model.dart';
import 'package:akwatv/providers/subscription_provider.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/home/subscription/congratulation_page.dart';
import 'package:akwatv/views/home/subscription/widgets/sub_dialogs.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:akwatv/views/routes_args/congratulations_args.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_paystack_payment/flutter_paystack_payment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class SubScriptionViewModel extends BaseViewModel {
  int selectedIndex = 0;
  String subName = 'Regular';
  double subAmount = 500.00;
  final plugin = PaystackPayment();
  bool saveData = false;
  DateTime today = DateTime.now();
  String expiredAt = DateTime.now().add(const Duration(days: 30)).toString();
  FutureManager<PaymentHistoryModel> payHistoryData = FutureManager();
  bool payLoader = false;
  SubScriptionViewModel(Reader read) : super(read) {
    subPlans();
    plugin.initialize(publicKey: payStackAPIKey);
  }

  List<Map<String, dynamic>> subPlans() {
    return [
      {
        "name": "Regular",
        "description": "Unlimited video Streaming.",
        "description2": "Limited to one Device.",
        "amount": "500.00",
        "onTap": () => changeIndex(index: 0, name: 'Regular', amount: 500.00)
      },
      {
        "name": "Premium",
        "description": "Unlimited video Streaming.",
        "description2": "Multiple Devices allowed.",
        "amount": "1,500.00",
        "onTap": () => changeIndex(index: 1, name: 'Premium', amount: 1500.00)
      }
    ];
  }

  void sendPaymentToPaystack({
    required BuildContext context,
    required double amount,
  }) async {
    Charge charge = Charge()
      // Convert to kobo and round to the nearest whole number
      ..amount = (amount * 100).round()
      ..email = PreferenceUtils.getString(key: 'email')
      ..card = _getCardFromUI()
      ..reference = _getReference();
    var checkout =
        plugin.checkout(context, charge: charge, method: CheckoutMethod.card);
    var response = await checkout;
    print('Paystack response =========== ${response.toString()}');
    if (response.status == true) {
      //Navigator.pop(context);
      //save and send payment and subscription details to admin.
      savePaymentSubResponse(
          context: context,
          amount: amount,
          paystackResponse: response.toString());
    } else {}
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: '',
      cvc: '',
      expiryMonth: '',
      expiryYear: '',
    );
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

  savePaymentSubResponse(
      {required BuildContext context,
      required dynamic amount,
      required String paystackResponse}) async {
    saveData = true;
    notifyListeners();

    final res = await read(subScriptionServices).savePaymentResponse(
        planName: subName,
        email: PreferenceUtils.getString(key: 'email'),
        username: PreferenceUtils.getString(key: 'username'),
        amount: amount,
        createdAt: today.toString(),
        expiredAt: expiredAt,
        paystackResponse: paystackResponse);

    if (res.message == 'Request successful') {
      PreferenceUtils.setString(key: 'subName', value: subName);
      PreferenceUtils.setString(
          key: 'subAmount', value: res.data!.subscription!.amount);
      LocalStorageManager.box
          .write('expiredAt', res.data!.subscription!.expiredAt);
      LocalStorageManager.box
          .write('isSubActive', res.data!.subscriptionIsActive);

      saveData = false;
      checkPaymentStatus(context, onTap: () {
        Get.to(() => const CongratulationScreen(),
            arguments: CongratulationsArgs(
                payLater: false,
                name: PreferenceUtils.getString(key: 'username'),
                title: 'You have Subscribed to Akwa Amaka TV !',
                subtitle: 'Your plan will expire on',
                date: res.data!.subscription!.expiredAt));
      });
      notifyListeners();
    } else {
      saveData = false;
      notifyListeners();
    }
    saveData = false;
  }

  getPaymentHistoryService() async {
    payLoader = true;
    payHistoryData.load();
    notifyListeners();

    final res = await read(subScriptionServices).getUsersPaymentHistory();

    if (res.message == 'Request successful') {
      payHistoryData.onSuccess(res);
      payLoader = false;
      notifyListeners();
    } else {
      payLoader = false;
      payHistoryData.onError(res.message!);
      notifyListeners();
    }
  }

  void changeIndex(
      {required int index,
      required String name,
      required dynamic amount}) async {
    selectedIndex = index;
    subAmount = amount;
    subName = name;

    notifyListeners();
  }
}
