import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubScriptionViewModel extends BaseViewModel {
  int selectedIndex = 0;
  SubScriptionViewModel(Reader read) : super(read) {
    subPlans();
  }

  List<Map<String, dynamic>> subPlans() {
    return [
      {
        "name": "Regular",
        "description": "Sream limited videos",
        "amount": "500.00",
        "onTap": () {}
      },
      {
        "name": "Premium",
        "description": "Unlimited video Streaming",
        "amount": "1,500.00",
        "onTap": () {}
      }
    ];
  }

  void changeIndex(int index) async {
    selectedIndex = index;
    notifyListeners();
  }
}
