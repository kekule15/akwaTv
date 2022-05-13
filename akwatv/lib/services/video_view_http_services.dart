import 'dart:convert';

import 'package:akwatv/http/api_manager.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/user_model.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/views/onboarding/auth_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class VideoViewService extends ApiManager {
  final Reader reader;
  GetStorage box = GetStorage();

  final getvideoListUrl = '/movies';

  VideoViewService(this.reader) : super(reader);

  // get list of videos
  Future<List<HomeVideoModel>?> getListOfVideos() async {
    final response = await getHttp(getvideoListUrl, token: box.read('token'));

    if (response.responseCodeError == null) {
      List data = response.data;
      final userDataList = data.map((e) => HomeVideoModel.fromJson(e)).toList();
      return userDataList;
    } else if (response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 404) {
      // box.erase();
      Get.to(() => const AuthScreen());
      //  return List<HomeVideoModel>(

      // );
    } else {
      // return GetProfileModel(
      //   success: false,
      // );
    }
  }
}
