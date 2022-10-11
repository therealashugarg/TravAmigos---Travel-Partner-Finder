// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travelamigos/constants.dart';
import 'package:travelamigos/services/database.dart';
import 'package:travelamigos/controllers/user_controller.dart';
import 'package:travelamigos/models/usermodel/user_model.dart' as model;
import 'package:travelamigos/views/screens/auth/welcome.dart';
import 'package:travelamigos/views/screens/home/home_page.dart';

class AuthController extends GetxController {
  var isPasswordHidden = true.obs;

  static AuthController instance = Get.find();
  late Rx<User?> _user;

  User get user => _user.value!;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    Get.put<UserController>(UserController());
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }



  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => Welcome());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  void register(String email, password, username) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      // create user
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        model.UserModel _user = model.UserModel(
            uid: user!.uid,
            email: email,
            username: username,
            age: null,
            name: null,
            location: null,
            about: null);
        await firestore
            .collection('users')
            .doc(user.uid)
            .set(_user.toJson());
        // if (await Database().createNewUser(_user)) {
        //   Get.find<UserController>().user = _user;
        // }
      }));
    } catch (e) {
      Get.snackbar("About User", "User message",
          backgroundColor: darkPurple.withOpacity(0.4),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("Account creation failed",
              style: TextStyle(color: whiteColor)),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: whiteColor),
          ));
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      Get.find<UserController>().user = await Database().getUser(user!.uid);
    } catch (e) {
      try {
        QuerySnapshot snap = await FirebaseFirestore.instance
            .collection("users")
            .where("username", isEqualTo: email)
            .get();
        await auth.signInWithEmailAndPassword(
            email: snap.docs[0]['email'], password: password);
      } catch (e) {
        Get.snackbar("About Login", "Login message",
            backgroundColor: darkPurple.withOpacity(0.4),
            snackPosition: SnackPosition.BOTTOM,
            titleText:
                Text("Login failed", style: TextStyle(color: whiteColor)),
            messageText: Text(
              e.toString(),
              style: TextStyle(color: whiteColor),
            ));
      }
    }
  }

  void logOut() async {
    await auth.signOut();
    Get.find<UserController>().clear();
  }
}
