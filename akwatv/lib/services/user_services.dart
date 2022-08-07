import 'package:akwatv/models/login__response_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserService {
  static const userBox = 'User';
  static const boxIndex = 0;

  // static void addUser(UserModel? user) async {
  //   var box = Hive.box<UserModel?>(userBox);
  //   await box.put(boxIndex, user);
  // }

  // static void updateUser(UserModel? user) async {
  //   var box = Hive.box<UserModel?>(userBox);
  //   box.putAt(boxIndex, user);
  // }

  // static Future<UserModel?> getUser() async {
  //   var box = Hive.box<UserModel?>(userBox);
  //   return box.get(boxIndex);
  // }

  // static void deleteUser() async {
  //   var box = Hive.box<UserModel?>(userBox);
  //   await box.delete(userBox);
  // }
}
