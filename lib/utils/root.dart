import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelamigos/controllers/auth_controller.dart';
import 'package:travelamigos/controllers/user_controller.dart';
import 'package:travelamigos/views/screens/auth/welcome.dart';
import 'package:travelamigos/views/screens/home/home_page.dart';

class Root extends GetWidget<AuthController> {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().auth.currentUser != null) {
          return HomePage();
        } else {
          return const Welcome();
        }
      },
    );
  }
}