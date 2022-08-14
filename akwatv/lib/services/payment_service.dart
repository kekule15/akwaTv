import 'dart:convert';

import 'package:akwatv/http/api_manager.dart';
import 'package:akwatv/models/addto_watchlist_model.dart';
import 'package:akwatv/models/category_model.dart';
import 'package:akwatv/models/delete_watchlist_model.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/get_watchList_model.dart';
import 'package:akwatv/models/save_sub_response_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/login__response_model.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/temporary_storage.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class PaymentService extends ApiManager {
  final Reader reader;
  

  final saveSubResponseUrl = 'api/subscription/save-response/';

  PaymentService(this.reader) : super(reader);

  // // add to watchList
  Future<SaveSubResponseModel> savePaymentResponse(
      {required String planName,
      required String email,
      required String username,
      required dynamic amount,
      required String createdAt,
      required String expiredAt,
      required String paystackResponse}) async {
    final body = {
      "sub_plan": planName,
      "email": email,
      "username": username,
      "amount": amount,
      "createdAt": createdAt,
      "expiredAt": expiredAt,
      "paystackResponse": paystackResponse
    };

    final response = await putHttp(
      saveSubResponseUrl + PreferenceUtils.getString(key: 'userId'),
      body,
      token:  PreferenceUtils.getString(key: 'token'),
    );

    if (response.responseCodeError == null) {
      return SaveSubResponseModel.fromJson(response.data);
    } else {
      return SaveSubResponseModel(message: 'Error');
    }
  }
}
