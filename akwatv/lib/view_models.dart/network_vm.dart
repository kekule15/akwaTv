import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetWorkViewModel extends BaseViewModel {
  NetWorkViewModel(Reader read) : super(read) {
    checkNet();
  }

  bool? isCheck;

  checkNet() async {
    final result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      isCheck = true;
      notifyListeners();
    } else {
      isCheck = false;
      notifyListeners();
    }

    return isCheck;
  }
}
