import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:grocery_app/controller/controller_state.dart';
import 'package:grocery_app/controller/views/sign_in.dart'; // adjust import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authController.logout();
              // Optional: navigate back to sign-in screen after logout
              Get.off(SigninScreen()); // or Get.offAll(() => SigninScreen());
            },
          ),
        ],
      ),
      body: const Center(child: Text('Welcome to the Grocery App!')),
    );
  }
}
