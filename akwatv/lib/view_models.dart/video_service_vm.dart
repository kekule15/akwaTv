//import 'dart:developer' as _logger;

import 'package:akwatv/models/category_model.dart';
import 'package:akwatv/models/future_manager.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/login)response_model.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/providers/video_view_provider.dart';
import 'package:akwatv/services/user_services.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/notify_me.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/router.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/onboarding/congratulation_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

class VideoServiceViewModel extends BaseViewModel {
  final Reader read;
  FutureManager<HomeVideoModel> listVideoData = FutureManager();
  FutureManager<CategoryModel> categoryListData = FutureManager();
  VideoServiceViewModel(this.read) : super(read) {
    getVideoList();
    getCategoryList();
  }
  GetStorage box = GetStorage();

  getVideoList() async {
    listVideoData.load();
    setContentError('');
    setErrorMessage('');
    setBusy(true);
    final res = await read(videoServiceProvider).getListOfVideos();
    if (res != null) {
      listVideoData.onSuccess(res);
      notifyListeners();
    } else {
      listVideoData.onError;
    }
    setBusy(false);
  }

  getCategoryList() async {
    categoryListData.load();
    final res = await read(videoServiceProvider).getCategoryList();
    if (res != null) {
      categoryListData.onSuccess(res);
      notifyListeners();
    } else {
      categoryListData.onError;
    }
    setBusy(false);
  }
}
