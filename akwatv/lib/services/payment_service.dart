import 'dart:convert';

import 'package:akwatv/http/api_manager.dart';
import 'package:akwatv/models/addto_watchlist_model.dart';
import 'package:akwatv/models/category_model.dart';
import 'package:akwatv/models/delete_watchlist_model.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/get_watchList_model.dart';
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

class PaymentService extends ApiManager {
  final Reader reader;
  GetStorage box = GetStorage();

  final getvideoListUrl = "api/movies";
  final categoryListUrl = 'api/lists';
  final addToWatchListUrl = 'api/user/addToWatchlist';
  final deleteWatchListUrl = 'api/user/deleteFromWatchlist';
  final getWatchListUrl = 'api/user/getWatchlist/';

  PaymentService(this.reader) : super(reader);

  // // add to watchList
  // Future<AddToWatchListModel?> addToWatchList(
  //     {required dynamic movieID}) async {
  //   final body = {"user_id": box.read('userId'), "movie_id": movieID};

  //   final response = await postHttp(
  //     addToWatchListUrl,
  //     body,
  //     token: box.read('token'),
  //   );

  //   if (response.responseCodeError == null) {
  //     return AddToWatchListModel.fromJson(response.data);
  //   } else {
  //     return AddToWatchListModel(message: 'Error');
  //   }
  // }

}
