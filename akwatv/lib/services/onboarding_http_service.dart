import 'dart:convert';
import 'dart:developer';

import 'package:akwatv/http/api_manager.dart';
import 'package:akwatv/models/change_user_password_model.dart';
import 'package:akwatv/models/forgot_password_model.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/logout_response_model.dart';
import 'package:akwatv/models/notification_model.dart';
import 'package:akwatv/models/otp_verification_model.dart';
import 'package:akwatv/models/rest_password_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/login__response_model.dart';
import 'package:akwatv/models/update_device_token_model.dart';
import 'package:akwatv/models/update_user_model.dart';
import 'package:akwatv/models/upload_pic_model.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/utils/notify_me.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class OnBoardingService extends ApiManager {
  final Reader reader;

  final logoutUrl = 'api/auth/logout/';
  final signupRoute = 'api/auth/register';
  final loginRoute = 'api/auth/login';
  final getProfileUrl = 'api/auth/get-user/';
  final changeUserPasswordUrl = 'api/auth/update/password';
  final uploadPicUrl = 'image/upload/';
  final forgotPasswordUrl = 'api/auth/forgot-password';
  final otpVerificationUrl = 'api/auth/verify-token';
  final resetPasswordUrl = 'api/auth/reset-password';
  final updateUserUrl = 'api/user/update/';
  final updateDeviceUrl = 'api/auth/update-device-token/';
  final notificationUrl = 'api/user/getNotificationList/';

  OnBoardingService(this.reader) : super(reader);

  // logout service
  Future<LogoutResponseModel> logoutService() async {
    final response = await getHttp(
        logoutUrl + PreferenceUtils.getString(key: 'userId'),
        token: PreferenceUtils.getString(key: 'token'));
    if (response.responseCodeError == null) {
      return LogoutResponseModel.fromJson(response.data);
    } else if (response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 404) {
      // box.erase();
      Get.to(() => const AuthScreen());
      return LogoutResponseModel(
        message: 'Error',
      );
    } else {
      return LogoutResponseModel(
        message: 'Error',
      );
    }
  }

  //Login with email and password
  Future<LoginResponseModel> signIn(
    String email,
    String password,
  ) async {
    final _signInBody = {
      "email": email,
      "password": password,
      "userAgent": PreferenceUtils.getString(key: 'deviceId')
    };

    final response =
        await postHttp(loginRoute, _signInBody).catchError((error) {
      return NotifyMe.showAlert('Error Occured... Please try again later.');
    });
    // print(response.data);
    if (response.statusCode == 502 || response.statusCode == 500) {
      NotifyMe.showAlert('Error Occured... Please try again later.');
      return LoginResponseModel(
          message: 'Error Occured... Please try again later.');
    } else {
      if (response.responseCodeError == null) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        return LoginResponseModel(
            message: 'Error Occured... Please try again later.');
      }
    }
  }

  //Sigup with email,password,phonenumber, username
  Future signUp(
    String name,
    String email,
    String password,
    String phoneNumber,
  ) async {
    final signUpBody = {
      "username": name,
      "email": email,
      "password": password,
      "confirm_password": password,
      "phone": phoneNumber,
      "verified": false
    };
    try {
      final response = await postHttp(signupRoute, signUpBody);

      return response.data;
    } catch (e) {
      log('my error message $e');
      return e;
    }

    // if (response.responseCodeError == null) {
    //   return SignUpModel.fromJson(response.data);
    // } else {
    //   return SignUpModel.fromJson(response.data);
    // }
  }

  // get profile details
  Future<GetProfileModel> getProfileService() async {
    print('my user ID ${PreferenceUtils.getString(key: 'userId')}');
    final response = await getHttp(
        getProfileUrl + PreferenceUtils.getString(key: 'userId'),
        token: PreferenceUtils.getString(key: 'token'));
    if (response.responseCodeError == null) {
      return GetProfileModel.fromJson(response.data);
    } else if (response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 404) {
      // box.erase();
      Get.to(() => const AuthScreen());
      return GetProfileModel(
        message: 'Error',
      );
    } else {
      return GetProfileModel(
        message: 'Error',
      );
    }
  }

  //change user password
  Future<ChangeUserPassword> changeUserPassWord(
      {required String email,
      required String password,
      required String newPassword,
      required String confirmPassword}) async {
    final body = {
      "email": email,
      "password": password,
      "new_password": newPassword,
      "confirm_new_password": confirmPassword,
    };

    final response = await postHttp(changeUserPasswordUrl, body,
        token: PreferenceUtils.getString(key: 'token'));

    if (response.responseCodeError == null) {
      return ChangeUserPassword.fromJson(response.data);
    } else {
      return ChangeUserPassword.fromJson(response.data);
    }
  }

  //upload pic service
  Future<UploadPicModel> uploadPicService({
    required dynamic image,
  }) async {
    final body = {
      "image": image,
    };

    final response = await postHttp(
      uploadPicUrl + PreferenceUtils.getString(key: 'userId'),
      body,
      formdata: true,
      token: PreferenceUtils.getString(key: 'token'),
    );
    print('body sent $image');

    if (response.responseCodeError == null) {
      return UploadPicModel.fromJson(response.data);
    } else {
      return UploadPicModel(message: 'Error');
    }
  }

  //forgot password stage 1
  Future<ForgotPassWordModel> forgotPassword({
    required dynamic email,
  }) async {
    final body = {"email": email, "stage": 1};

    final response = await postHttp(
      forgotPasswordUrl,
      body,
      //token: box.read('token'),
    );

    if (response.responseCodeError == null) {
      return ForgotPassWordModel.fromJson(response.data);
    } else {
      return ForgotPassWordModel(message: 'Error');
    }
  }

  //forgot password stage 2 OTP verification
  Future<OtpVerificationModel> otpVerificationService({
    required dynamic email,
    required dynamic token,
  }) async {
    final body = {"email": email, "token": token, "stage": 2};

    final response = await postHttp(
      otpVerificationUrl,
      body,
    );

    if (response.responseCodeError == null) {
      return OtpVerificationModel.fromJson(response.data);
    } else {
      return OtpVerificationModel(message: 'Error');
    }
  }

  //forgot password stage 3 Reset Password
  Future<ResetPassWordModel> resetPassword({
    required dynamic email,
    required dynamic password,
  }) async {
    final body = {"email": email, "password": password, "stage": 3};

    final response = await postHttp(
      resetPasswordUrl,
      body,
    );

    if (response.responseCodeError == null) {
      return ResetPassWordModel.fromJson(response.data);
    } else {
      return ResetPassWordModel(message: 'Error');
    }
  }

  // update users details
  Future<UpdateUserResponseModel> updateUserProfile({
    required dynamic email,
    required dynamic phone,
    required dynamic username,
  }) async {
    final body = {"email": email, "phone": phone, "username": username};

    final response = await patchHttp(
        updateUserUrl + PreferenceUtils.getString(key: 'userId'), body,
        token: PreferenceUtils.getString(key: 'token'));

    if (response.responseCodeError == null) {
      return UpdateUserResponseModel.fromJson(response.data);
    } else {
      return UpdateUserResponseModel(message: 'Error');
    }
  }

  // update users device FCM token
  Future<UpdateDeviceModel> updateDeviceToken({
    required dynamic deviceToken,
    required dynamic userId,
  }) async {
    print('my device token ${PreferenceUtils.getString(key: 'token')}');
    final body = {"deviceToken": deviceToken};

    final response = await postHttp(updateDeviceUrl + userId, body,
        token: PreferenceUtils.getString(key: 'token'));
    print(" my device response ${response.data}");
    if (response.responseCodeError == null) {
      return UpdateDeviceModel.fromJson(response.data);
    } else {
      return UpdateDeviceModel(message: 'Error');
    }
  }

  //get users notification
  Future<UserNotificationModel> getNotification() async {
    print('my user ID ${PreferenceUtils.getString(key: 'userId')}');
    final response = await getHttp(
        notificationUrl + PreferenceUtils.getString(key: 'userId'),
        token: PreferenceUtils.getString(key: 'token'));
    if (response.responseCodeError == null) {
      return UserNotificationModel.fromJson(response.data);
    } else {
      return UserNotificationModel(
        message: 'Error',
      );
    }
  }
}
