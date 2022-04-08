import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends BaseViewModel {
  int selectedIndex = 0;
  HomeViewModel(Reader read) : super(read) {
   
  }


  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
