//import 'dart:developer' as _logger;

import 'package:akwatv/models/change_user_password_model.dart';
import 'package:akwatv/models/forgot_password_model.dart';
import 'package:akwatv/models/future_manager.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/notification_model.dart';
import 'package:akwatv/models/otp_verification_model.dart';
import 'package:akwatv/models/rest_password_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/login__response_model.dart';
import 'package:akwatv/models/update_user_model.dart';
import 'package:akwatv/models/upload_pic_model.dart';
import 'package:akwatv/utils/app_helpers.dart';
import 'package:akwatv/utils/notify_me.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/home/subscription/choose_plan.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/home/subscription/congratulation_page.dart';
import 'package:akwatv/views/onboarding/forgot_password/otp_verification_page.dart';
import 'package:akwatv/views/onboarding/forgot_password/reset_password_page.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:developer';

class LoginViewModel extends BaseViewModel {
  final Reader read;
  FutureManager<LoginResponseModel?> loginData = FutureManager();
  FutureManager<SignUpModel?> signupData = FutureManager();
  FutureManager<ChangeUserPassword?> changePasswordData = FutureManager();
  FutureManager<UploadPicModel?> uploadPicData = FutureManager();

  FutureManager<ForgotPassWordModel?> forgotPasswordData = FutureManager();
  FutureManager<OtpVerificationModel?> otpVerificationData = FutureManager();
  FutureManager<ResetPassWordModel?> resetPasswordData = FutureManager();
  FutureManager<UpdateUserResponseModel?> updateUserData = FutureManager();
  FutureManager<GetProfileModel?> userProfileData = FutureManager();
  FutureManager<UserNotificationModel?> notificationData = FutureManager();
  LoginViewModel(this.read) : super(read) {
    getProfile();
    // getNotifications();
  }
  bool logoutBTN = false;
  bool loginBtn = false;
  bool signupBtn = false;
  bool changePasswordBTN = false;
  bool uploadPicBTN = false;
  bool forgotPasswordBTN = false;
  bool otpLoader = false;
  bool resetPassword = false;
  bool updateUser = false;

  //logout service
  logoutNow() async {
    logoutBTN = true;
    notifyListeners();
    final res = await read(onboardingProvider).logoutService();
    if (res.message == 'ACT-LOGED-OUT-SUCCESS') {
      await PreferenceUtils.eraseAllData();
      await LocalStorageManager.box.erase();
      logoutBTN = false;
      NotifyMe.showAlert(res.message!);

      Get.offAll(() => const AuthScreen());
    }
  }

  // login service
  login(String email, String password) async {
    loginBtn = true;
    loginData.load();
    notifyListeners();

    final res = await read(onboardingProvider).signIn(email, password);

    if (res.message == 'ACT-LOGIN-SUCCESS') {
      loginData.onSuccess(res);
      //PreferenceUtils.getString(key: 'token')
      PreferenceUtils.setString(key: 'token', value: res.data!.accessToken);
      PreferenceUtils.setString(key: 'phone', value: res.data!.account!.phone);
      PreferenceUtils.setString(key: 'email', value: res.data!.account!.email);
      //  LocalStorageManager.box.write('avatar', res.data!.account!.avatar);
      PreferenceUtils.setString(
          key: 'avatar', value: res.data!.account!.avatar);
      PreferenceUtils.setString(
          key: 'username', value: res.data!.account!.username);
      PreferenceUtils.setBool(
          key: 'verified', value: res.data!.account!.verified);
      PreferenceUtils.setString(key: 'userId', value: res.data!.account!.id);
      // LocalStorageManager.box.write('cloudId', res.data!.account!.cloudinaryId);
      PreferenceUtils.setString(
          key: 'subName', value: res.data!.account!.subscription!.name);
      PreferenceUtils.setString(
          key: 'subAmount', value: res.data!.account!.subscription!.amount);
      // LocalStorageManager.box
      //     .write('expiredAt', res.data!.account!.subscription!.expiredAt);
      LocalStorageManager.box
          .write('isSubActive', res.data!.account!.subscriptionIsActive);

      var expireDate =
          formatter.format(res.data!.account!.subscription!.expiredAt!);
      LocalStorageManager.box.write('expiredAt', expireDate);

      await getProfile();
      NotifyMe.showAlert(res.message!);
      loginBtn = false;
      Get.offAll(() => const ChoosePlanPage());

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

  // register service
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
    log('my response $res');
    if (res['message'] == "Verification email sent") {
      signupData.onSuccess(res);
      NotifyMe.showAlert(res['message']);
      Get.to(() => const LoginPage());
      signupBtn = false;
      notifyListeners();
    } else if (res['message'] == 'ACT-EMAIL-EXIST') {
      signupData.onError;
      NotifyMe.showAlert(res['message']);
      signupBtn = false;
      notifyListeners();
    } else if (res['errors'] != null) {
      log('my error ${res['errors']!}');
      signupData.onError;
      NotifyMe.showAlert('ACT-PASSWORD-TOO-SHORT');
      signupBtn = false;
      notifyListeners();
    } else {
      signupData.onError;

      NotifyMe.showAlert(res['message']);
      signupBtn = false;
      notifyListeners();
    }
    signupBtn = false;
  }

  // get user details or profile
  Future getProfile() async {
    userProfileData.load();
    setContentError('');
    setErrorMessage('');
    setBusy(true);

    final res = await read(onboardingProvider).getProfileService();

    if (res.message != 'Error') {
      //await getVideoList();
      userProfileData.onSuccess(res);

      PreferenceUtils.setString(key: 'phone', value: res.data!.phone);
      PreferenceUtils.setString(key: 'email', value: res.data!.email);
      //  LocalStorageManager.box.write('avatar', res.data!.account!.avatar);
      PreferenceUtils.setString(key: 'avatar', value: res.data!.avatar);
      PreferenceUtils.setString(key: 'username', value: res.data!.username);
      PreferenceUtils.setBool(key: 'verified', value: res.data!.verified);
      PreferenceUtils.setString(key: 'userId', value: res.data!.id);
      // LocalStorageManager.box.write('cloudId', res.data!.account!.cloudinaryId);
      PreferenceUtils.setString(
          key: 'subName', value: res.data!.subscription!.name);
      PreferenceUtils.setString(
          key: 'subAmount', value: res.data!.subscription!.amount);
      // LocalStorageManager.box
      //     .write('expiredAt', res.data!.subscription!.expiredAt);
      LocalStorageManager.box
          .write('isSubActive', res.data!.subscriptionIsActive);

      var expireDate = formatter.format(res.data!.subscription!.expiredAt!);
      //debugPrint('hello active. $expireDate');
      LocalStorageManager.box.write('expiredAt', expireDate);

      notifyListeners();
    } else {
      userProfileData.onError;
    }
    setBusy(false);
  }

  // change user password
  Future changeUserPassword(
      {required String email,
      required String password,
      required String newPassword,
      required String confirmPassword}) async {
    changePasswordBTN = true;
    changePasswordData.load();
    notifyListeners();
    final res = await read(onboardingProvider).changeUserPassWord(
        email: email,
        password: password,
        newPassword: newPassword,
        confirmPassword: confirmPassword);

    if (res.message == "ACT-PASSWORD-RESET-SUCCESS") {
      changePasswordData.onSuccess(res);
      NotifyMe.showAlert(res.message!);
      changePasswordBTN = false;
      Get.back();
      notifyListeners();
    } else if (res.message == 'WRONG-PASSWORD-CODE') {
      changePasswordData.onError;
      NotifyMe.showAlert(res.message!);
      changePasswordBTN = false;
      notifyListeners();
    } else if (res.message == 'PASSWORD-CANT-BE-SAME-WITH-OLD-PASSWORD') {
      changePasswordData.onError;
      NotifyMe.showAlert(res.message!);
      changePasswordBTN = false;
      notifyListeners();
    } else if (res.message == 'Invalid requests') {
      changePasswordData.onError;
      NotifyMe.showAlert(res.message!);
      changePasswordBTN = false;
      notifyListeners();
    } else {
      changePasswordData.onError;
      NotifyMe.showAlert('Change of password was not completed');
      changePasswordBTN = false;
      notifyListeners();
    }
    changePasswordBTN = false;
  }

  // upload profile picture
  uploadProfilePic({required dynamic image}) async {
    uploadPicData.load();
    uploadPicBTN = true;
    notifyListeners();

    final res = await read(onboardingProvider).uploadPicService(image: image);

    if (res.message == 'Request successful') {
      uploadPicData.onSuccess(res);
      PreferenceUtils.setString(key: 'avatar', value: res.data!.user!.avatar);

      uploadPicBTN = false;
      notifyListeners();
    } else {
      uploadPicData.onError;
      uploadPicBTN = false;
      notifyListeners();
    }
    uploadPicBTN = false;
  }

  // forgot password stage 1
  forgotPasswordService({required dynamic email}) async {
    forgotPasswordData.load();
    forgotPasswordBTN = true;
    notifyListeners();

    final res = await read(onboardingProvider).forgotPassword(email: email);

    if (res.message == 'Verification token sent') {
      forgotPasswordData.onSuccess(res);
      forgotPasswordBTN = false;
      NotifyMe.showAlert(res.message!);
      Get.to(() => const OTPVerificationPage());
      notifyListeners();
    } else {
      NotifyMe.showAlert(res.message!);
      forgotPasswordData.onError;
      forgotPasswordBTN = false;
      notifyListeners();
    }
    forgotPasswordBTN = false;
  }

  // forgot password stage 2 OTP Verification
  otpVerificationService(
      {required dynamic email, required dynamic token}) async {
    otpVerificationData.load();
    otpLoader = true;
    notifyListeners();

    final res = await read(onboardingProvider)
        .otpVerificationService(email: email, token: token);

    if (res.message == 'Request successful') {
      otpVerificationData.onSuccess(res);
      otpLoader = false;
      NotifyMe.showAlert(res.message!);
      Get.to(() => const ResetPasswordPage());
      notifyListeners();
    } else {
      otpVerificationData.onError;
      NotifyMe.showAlert(res.message!);
      otpLoader = false;
      notifyListeners();
    }
    otpLoader = false;
  }

  // forgot password stage 3 Reset Password
  resetPasswordService(
      {required dynamic email, required dynamic password}) async {
    resetPasswordData.load();
    resetPassword = true;
    notifyListeners();

    final res = await read(onboardingProvider)
        .resetPassword(email: email, password: password);

    if (res.message == 'ACT-PASSWORD-RESET-SUCCESS') {
      resetPasswordData.onSuccess(res);
      resetPassword = false;
      NotifyMe.showAlert(res.message!);
      Get.to(() => const LoginPage());
      notifyListeners();
    } else {
      resetPasswordData.onError;
      NotifyMe.showAlert(res.message!);
      resetPassword = false;
      notifyListeners();
    }
    resetPassword = false;
  }

  // update user profile details
  updateUserProfile(
      {required dynamic email,
      required dynamic phone,
      required dynamic username}) async {
    updateUserData.load();
    updateUser = true;
    notifyListeners();

    final res = await read(onboardingProvider)
        .updateUserProfile(email: email, phone: phone, username: username);

    if (res.message == 'Request successful') {
      updateUserData.onSuccess(res);
      PreferenceUtils.setString(key: 'phone', value: res.data!.phone);
      PreferenceUtils.setString(key: 'email', value: res.data!.email);
      PreferenceUtils.setString(key: 'username', value: res.data!.username);

      updateUser = false;
      NotifyMe.showAlert(res.message!);
      Get.back();
      notifyListeners();
    } else {
      updateUserData.onError;
      NotifyMe.showAlert(res.message!);
      updateUser = false;
      notifyListeners();
    }
    updateUser = false;
  }

  // update device token
  updateDeviceTokenService({required dynamic deviceToken}) async {
    final res = await read(onboardingProvider).updateDeviceToken(
        deviceToken: deviceToken,
        userId: PreferenceUtils.getString(key: 'userId'));
    return res;
  }

  // get User notifications
  getNotifications() async {
    notificationData.load();
    notifyListeners();
    final res = await read(onboardingProvider).getNotification();
    if (res.message == 'Request successful') {
      notificationData.onSuccess(res);
      notifyListeners();
    } else {
      notificationData.onError('Error');
      notifyListeners();
    }
    resetPassword = false;
  }
}
