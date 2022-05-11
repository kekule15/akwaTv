import 'package:akwatv/providers/navigators.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseViewModel extends ChangeNotifier {
  final Reader read;
  late NavigationService _navigationService;
  String _pinErrorMessage = '';

  String get pinErrorMessage => _pinErrorMessage;

  BaseViewModel(this.read) {
    _navigationService = read(navService);
  }
  bool _busy = false;
  String _contentError = '';
  String _errorMessage = '';

  bool get busy => _busy;
  String get contentError => _contentError;
  String get errorMessage => _errorMessage;
  bool get hasErrorMessage => _errorMessage != '' && _errorMessage.isNotEmpty;

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setContentError(String message) {
    _contentError = message;
    notifyListeners();
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  setPinErrorMessage(String message) {
    _pinErrorMessage = message;
    notifyListeners();
  }

  bool validateAndSave(GlobalKey<FormState> _key) {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void pop() {
    _navigationService.goBack();
  }

  void navigateTo(String destination, {dynamic arguments}) async {
    await _navigationService.navigateTo(destination, arguments: arguments);
  }

  void navigateToReplacement(String destination, {dynamic arguments}) async {
    await _navigationService.navigateToReplacement(destination,
        arguments: arguments);
  }

  void navigateAndClearHistory(String destination, {dynamic arguments}) async {
    await _navigationService.navigateAndClearHistory(destination,
        arguments: arguments);
  }
}
