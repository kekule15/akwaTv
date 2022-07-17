import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends BaseViewModel {
  int selectedIndex = 0;
  HomeViewModel(Reader read) : super(read) {}

  void changeIndex(int index) async {
    if (index == 3) {
      await read(videoViewModel).getAllWatchList();
    }
    if (index == 0) {
      await read(videoViewModel).getCategoryList();
    }
    selectedIndex = index;
    notifyListeners();
  }
}
