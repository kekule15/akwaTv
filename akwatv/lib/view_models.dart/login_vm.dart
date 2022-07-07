//import 'dart:developer' as _logger;

import 'package:akwatv/models/future_manager.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/login)response_model.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/services/user_services.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/notify_me.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/router.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/onboarding/congratulation_page.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

class LoginViewModel extends BaseViewModel {
  final Reader read;
  FutureManager<LoginResponseModel?> loginData = FutureManager();
  FutureManager<SignUpModel?> signupData = FutureManager();
  FutureManager<GetProfileModel?> userProfileData = FutureManager();
  LoginViewModel(this.read) : super(read) {
    getProfile(userId: box.read('userId'));
  }

  bool loginBtn = false;
  bool signupBtn = false;
  GetStorage box = GetStorage();
  login(String email, String password) async {
    loginBtn = true;
    loginData.load();
    notifyListeners();

    final res = await read(onboardingProvider).signIn(email, password);

    if (res.message == 'ACT-LOGIN-SUCCESS') {
      loginData.onSuccess(res);
      box.write('token', res.data!.accessToken);
      box.write('phone', res.data!.account!.phone);
      box.write('avatar', res.data!.account!.avatar);
      box.write('email', res.data!.account!.email);
      box.write('username', res.data!.account!.username);
      box.write('verified', res.data!.account!.verified);
      box.write('cloudId', res.data!.account!.cloudinaryId);
      box.write('userId', res.data!.account!.id);
      NotifyMe.showAlert(res.message!);
      loginBtn = false;
      Get.offAll(() => const CongratulationScreen());

      // await getProfile(userId: res.data!.account!.id);
      notifyListeners();
    } else if (res.message == 'USER-NOT-VERIFIED') {
      loginBtn = false;

      NotifyMe.showAlert(
          "Verify your email address to complete the sign up and login into your account");

      loginData.onError;
      notifyListeners();
    } else if (res.message == 'ACT-INVALID-LOGIN') {
      loginBtn = false;
      NotifyMe.showAlert(res.message!);

      loginData.onError;
      notifyListeners();
    } else if (res.message == 'USER-NOT-FOUND') {
      loginBtn = false;
      NotifyMe.showAlert(res.message!);

      loginData.onError;
      notifyListeners();
    } else {
      loginBtn = false;
      NotifyMe.showAlert(res.message!);

      loginData.onError;
      notifyListeners();
    }
    loginBtn = false;
  }

  register(
    String name,
    String email,
    String password,
    String phoneNumber,
  ) async {
    signupBtn = true;
    signupData.load();
    notifyListeners();
    final res = await read(onboardingProvider)
        .signUp(name, email, password, phoneNumber);

    if (res.message == "Verification email sent") {
      signupData.onSuccess(res);
      NotifyMe.showAlert(res.message!);
      Get.to(() => const LoginPage());
      signupBtn = false;
      notifyListeners();
    } else if (res.message == 'ACT-EMAIL-EXIST') {
      signupData.onError;
      NotifyMe.showAlert(res.message!);
      signupBtn = false;
      notifyListeners();
    } else {
      signupData.onError;
      NotifyMe.showAlert(
          'Registration was not completed. Phone number already used.');
      signupBtn = false;
      notifyListeners();
    }
    signupBtn = false;
  }

  Future getProfile({required dynamic userId}) async {
    userProfileData.load();
    setContentError('');
    setErrorMessage('');
    setBusy(true);

    final res =
        await read(onboardingProvider).getProfileService(userId: userId);

    if (res.message != 'Error') {
      //await getVideoList();
      userProfileData.onSuccess(res);

      box.write('phone', res.data!.phone);
      box.write('avatar', res.data!.avatar);
      box.write('email', res.data!.email);
      box.write('username', res.data!.username);
      box.write('verified', res.data!.verified);
      box.write('cloudId', res.data!.cloudinaryId);
      box.write('userId', res.data!.id);
      notifyListeners();
    } else {
      userProfileData.onError;
    }
    setBusy(false);
  }
}
