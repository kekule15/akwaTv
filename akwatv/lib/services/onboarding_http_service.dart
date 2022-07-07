import 'dart:convert';

import 'package:akwatv/http/api_manager.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/login)response_model.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class OnBoardingService extends ApiManager {
  final Reader reader;
  GetStorage box = GetStorage();
  final signupRoute = 'auth/register';
  final loginRoute = 'auth/login';
  final getProfileUrl = 'auth/get-user/';

  OnBoardingService(this.reader) : super(reader);

  //Login with email and password
  Future<LoginResponseModel> signIn(
    String email,
    String password,
  ) async {
    final _signInBody = {
      "email": email,
      "password": password,
    };

    final response = await postHttp(loginRoute, _signInBody);
    if (response.responseCodeError == null) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      return LoginResponseModel.fromJson(response.data);
    }
  }

  //Sigup with email,password,phonenumber, username
  Future<SignUpModel> signUp(
    String name,
    String email,
    String password,
    String phoneNumber,
  ) async {
    final _signUpBody = {
      "username": name,
      "email": email,
      "password": password,
      "confirm_password": password,
      "phone": phoneNumber,
      "verified": false
    };
    final response = await postHttp(signupRoute, _signUpBody);
    if (response.responseCodeError == null) {
      return SignUpModel.fromJson(response.data);
    } else {
      return SignUpModel.fromJson(response.data);
    }
  }

  // get profile details
  Future<GetProfileModel> getProfileService({required dynamic userId}) async {
    final response =
        await getHttp(getProfileUrl + '$userId', token: box.read('token'));
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
}
