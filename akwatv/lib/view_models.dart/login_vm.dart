//import 'dart:developer' as _logger;

import 'package:akwatv/models/future_manager.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/user_model.dart';
import 'package:akwatv/services/user_services.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/notify_me.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/router.dart';
import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/onboarding/congratulation_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

class LoginViewModel extends BaseViewModel {
  final Reader read;
  FutureManager<UserModel?> loginData = FutureManager();
  FutureManager<SignUpModel?> signupData = FutureManager();
  FutureManager<GetProfileModel?> userProfileData = FutureManager();
  LoginViewModel(this.read) : super(read) {
    getProfile();
  }
  GetStorage box = GetStorage();
  login(String email, String password) async {
    loginData.load();
    setContentError('');
    setErrorMessage('');
    setBusy(true);
    final res = await read(onboardingProvider)
        .signIn(email, password)
        .catchError((onError) {
      NotifyMe.showAlert('Oops!... Something went wront. Try again later');
    });

    if (res.id != '00') {
      loginData.onSuccess(res);
      box.write('token', res.accessToken);
      await getProfile();
      notifyListeners();
    } else {
      NotifyMe.showAlert('Wrong password or username!');

      loginData.onError;
      setErrorMessage('Wrong password or username!');
    }
    setBusy(false);
  }

  register(
    String name,
    String email,
    String password,
    String phoneNumber,
  ) async {
    loginData.load();
    setContentError('');
    setErrorMessage('');
    setBusy(true);
    final res = await read(onboardingProvider)
        .signUp(name, email, password, phoneNumber)
        .catchError((onError) {
      NotifyMe.showAlert('Oops!... Something went wront. Try again later');
    });

    if (res.id != '00') {
      signupData.onSuccess(res);
      notifyListeners();
    } else {
      NotifyMe.showAlert('Registration was not completed.');

      signupData.onError;
      setErrorMessage('Registration was not completed.');
    }
    setBusy(false);
  }

  Future getProfile() async {
    userProfileData.load();
    setContentError('');
    setErrorMessage('');
    setBusy(true);

    final res = await read(onboardingProvider).getProfileService();

    if (res.success != false) {
      print(res.data);
      userProfileData.onSuccess(res);
      notifyListeners();
    } else {
      userProfileData.onError;
    }
    setBusy(false);
  }
}
