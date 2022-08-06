import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubScriptionViewModel extends BaseViewModel {
  int selectedIndex = 0;
  String subName = 'Regular';
  double subAmount = 500.00;
  SubScriptionViewModel(Reader read) : super(read) {
    subPlans();
  }

  List<Map<String, dynamic>> subPlans() {
    return [
      {
        "name": "Regular",
        "description": "Sream limited videos",
        "amount": "500.00",
        "onTap": () => changeIndex(index: 0, name: 'Regular', amount: 500.00)
      },
      {
        "name": "Premium",
        "description": "Unlimited video Streaming",
        "amount": "1,500.00",
        "onTap": () => changeIndex(index: 1, name: 'Premium', amount: 1500.00)
      }
    ];
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
