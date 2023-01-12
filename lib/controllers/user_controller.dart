// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:travelamigos/models/usermodel/user_model.dart';
 
class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => _userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }
}