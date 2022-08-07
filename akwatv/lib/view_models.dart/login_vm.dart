//import 'dart:developer' as _logger;

import 'package:akwatv/models/change_user_password_model.dart';
import 'package:akwatv/models/forgot_password_model.dart';
import 'package:akwatv/models/future_manager.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/otp_verification_model.dart';
import 'package:akwatv/models/rest_password_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/login__response_model.dart';
import 'package:akwatv/models/upload_pic_model.dart';
import 'package:akwatv/utils/notify_me.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/home/subscription/choose_plan.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:akwatv/views/home/subscription/congratulation_page.dart';
import 'package:akwatv/views/onboarding/forgot_password/otp_verification_page.dart';
import 'package:akwatv/views/onboarding/forgot_password/reset_password_page.dart';
import 'package:akwatv/views/onboarding/signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginViewModel extends BaseViewModel {
  final Reader read;
  FutureManager<LoginResponseModel?> loginData = FutureManager();
  FutureManager<SignUpModel?> signupData = FutureManager();
  FutureManager<ChangeUserPassword?> changePasswordData = FutureManager();
  FutureManager<UploadPicModel?> uploadPicData = FutureManager();

  FutureManager<ForgotPassWordModel?> forgotPasswordData = FutureManager();
  FutureManager<OtpVerificationModel?> otpVerificationData = FutureManager();
  FutureManager<ResetPassWordModel?> resetPasswordData = FutureManager();
  FutureManager<GetProfileModel?> userProfileData = FutureManager();
  LoginViewModel(this.read) : super(read) {
    getProfile(userId: box.read('userId'));
  }

  bool loginBtn = false;
  bool signupBtn = false;
  bool changePasswordBTN = false;
  bool uploadPicBTN = false;
  bool forgotPasswordBTN = false;
  bool otpLoader = false;
  bool resetPassword = false;

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
      //await getProfile(userId: res.data!.account!.id);
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

      box.write('avatar', res.data!.user!.avatar);
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
}
