import 'package:akwatv/http/api_manager.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/user_model.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingService extends ApiManager {
  final Reader reader;
  GetStorage box = GetStorage();
  final signupRoute = '/auth/register';
  final loginRoute = '/auth/login';
  final getProfileUrl = '/auth/getMe';

  OnBoardingService(this.reader) : super(reader);

  //Login with email and password
  Future<UserModel> signIn(
    String email,
    String password,
  ) async {
    final _signInBody = {
      "email": email,
      "password": password,
    };

    final response = await postHttp(loginRoute, _signInBody);
    if (response.responseCodeError == null) {
      return UserModel.fromJson(response.data);
    } else {
      return UserModel(
        id: '00',
      );
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
      "phone": phoneNumber,
    };
    final response = await postHttp(signupRoute, _signUpBody);
    if (response.responseCodeError == null) {
      return SignUpModel.fromJson(response.data);
    } else {
      return SignUpModel(id: '00');
    }
  }

  // get profile details
  Future<GetProfileModel> getProfileService() async {
    final response = await getHttp(getProfileUrl, token: box.read('token'));
    if (response.responseCodeError == null) {
      return GetProfileModel.fromJson(response.data);
    } else {
      return GetProfileModel(
        success: false,
      );
    }
  }
}
