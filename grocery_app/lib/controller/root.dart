import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controller/controller_state.dart';
import 'package:grocery_app/controller/views/sign_in.dart';

import 'package:grocery_app/home_screen.dart'; // your actual home screen

class Root extends StatelessWidget {
  Root({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.user != null) {
        return HomeScreen(); // 👈 your authenticated screen
      } else {
        return SigninScreen(); // 👈 your login screen
      }
    });
  }
}
