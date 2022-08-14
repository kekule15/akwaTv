import 'package:get_storage/get_storage.dart';
import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager {
  // static GetStorage box = GetStorage();
  // static GetStorage fcmStorage = GetStorage();
  // static GetStorage devicePlatformInfo = GetStorage();
}

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static String getString({required dynamic key}) {
    return _prefsInstance!.getString(key) ?? "";
  }

  static Future<bool> setString(
      {required String key, required dynamic value}) async {
    var prefs = await _instance;
    return prefs.setString(key, value!);
  }
   static Future<bool> setBool(
      {required String key, required bool? value}) async {
    var prefs = await _instance;
    return prefs.setBool(key, value!);
  }

   static Future<bool> getBool({required dynamic key}) async{
      var prefs = await _instance;
    return prefs.getBool(key) ?? false;
  }

  static Future eraseAllData() async {
    var prefs = await _instance;

    return prefs.clear();
  }
}
