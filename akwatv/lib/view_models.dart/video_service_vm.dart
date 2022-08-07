//import 'dart:developer' as _logger;

import 'package:akwatv/models/addto_watchlist_model.dart';
import 'package:akwatv/models/category_model.dart';
import 'package:akwatv/models/delete_watchlist_model.dart';
import 'package:akwatv/models/future_manager.dart';
import 'package:akwatv/models/get_profile_model.dart';
import 'package:akwatv/models/get_watchList_model.dart';
import 'package:akwatv/models/sign_up_model.dart';
import 'package:akwatv/models/login__response_model.dart';
import 'package:akwatv/models/vidoe_model.dart';
import 'package:akwatv/providers/video_view_provider.dart';
import 'package:akwatv/services/user_services.dart';
import 'package:akwatv/utils/exports.dart';
import 'package:akwatv/utils/notify_me.dart';
import 'package:akwatv/utils/providers.dart';
import 'package:akwatv/utils/router.dart';
import 'package:akwatv/utils/video_model.dart';
import 'package:akwatv/view_models.dart/base_vm.dart';
import 'package:akwatv/views/home/subscription/congratulation_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

class VideoServiceViewModel extends BaseViewModel {
  final Reader read;
  FutureManager<HomeVideoModel> listVideoData = FutureManager();
  FutureManager<CategoryModel> categoryListData = FutureManager();
  FutureManager<AddToWatchListModel> addToWatchListData = FutureManager();
  FutureManager<GetWatchListModel> getWatchListData = FutureManager();
  FutureManager<DeleteWatchListModel> deleteWatchListData = FutureManager();
  VideoServiceViewModel(this.read) : super(read) {
    getVideoList();
    getCategoryList();
    getAllWatchList();
  }
  GetStorage box = GetStorage();
  bool addTOListBTN = false;
  bool deleteTOListBTN = false;
  bool getWatchLoader = false;

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

  //add to watch list

  addToWatchListService({required dynamic movieID}) async {
    addTOListBTN = true;
    addToWatchListData.load();
    notifyListeners();

    final res =
        await read(videoServiceProvider).addToWatchList(movieID: movieID);
    if (res != null) {
      addToWatchListData.onSuccess(res);
      NotifyMe.showAlert(res.message!);
      getAllWatchList();
      await read(loginViewModel).getProfile(userId: box.read('userId'));

      addTOListBTN = false;
      notifyListeners();
    } else {
      addTOListBTN = false;
      NotifyMe.showAlert(res!.message!);
      addToWatchListData.onError;
      notifyListeners();
    }
    addTOListBTN = false;
  }

//delete watchlist item
  deleteWatchListservice({required dynamic movieID}) async {
    deleteTOListBTN = true;
    deleteWatchListData.load();
    notifyListeners();

    final res =
        await read(videoServiceProvider).deleteWatchList(movieID: movieID);
    if (res != null) {
      deleteWatchListData.onSuccess(res);
      NotifyMe.showAlert(res.message!);
      await read(loginViewModel).getProfile(userId: box.read('userId'));
      getAllWatchList();
      deleteTOListBTN = false;
      notifyListeners();
    } else {
      deleteTOListBTN = false;
      NotifyMe.showAlert(res!.message!);
      deleteWatchListData.onError;
      notifyListeners();
    }
    deleteTOListBTN = false;
  }

  getAllWatchList() async {
    getWatchLoader = true;
    getWatchListData.load();
    notifyListeners();

    final res = await read(videoServiceProvider).getWatchList();
    if (res != null) {
      getWatchListData.onSuccess(res);
      getWatchLoader = false;
      notifyListeners();
    } else {
      getWatchLoader = false;
      getWatchListData.onError;
      notifyListeners();
    }
    getWatchLoader = false;
  }
}
