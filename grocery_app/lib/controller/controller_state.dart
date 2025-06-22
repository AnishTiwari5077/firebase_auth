import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rxn<User> _firebaseUser = Rxn<User>();
  final RxBool _isFirstTime = true.obs;

  User? get user => _firebaseUser.value;
  bool get isFirstTime => _isFirstTime.value;

  @override
  void onInit() {
    super.onInit();
    _isFirstTime.value = _storage.read('isFirstTime') ?? true;
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void setFirstTime() {
    _isFirstTime.value = true;
    _storage.write('isFirstTime', true);
  }

  void setFirstTimeDone() {
    _isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      setFirstTimeDone();
      _storage.write('email', email);
      _storage.write('password', password);
      _storage.write('isLoggedIn', true);

      Get.snackbar(
        'Success',
        'Logged in successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          message = 'Incorrect email or password.';
          break;
        case 'invalid-email':
          message = 'Email format is invalid.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        default:
          message = 'Login failed. Please try again.';
      }

      Get.snackbar(
        'Login Error',
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        'Success',
        'Account created successfully',
        backgroundColor: Colors.green,
        colorText: const Color.fromARGB(255, 255, 255, 255),
      );
    } catch (e) {
      Get.snackbar(
        'Registration failed',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.snackbar(
      'Logout',
      'You have been signed out',
      backgroundColor: Colors.green,
      colorText: const Color.fromARGB(255, 255, 255, 255),
    );
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Password Reset'
            'Password reset email sent',
        'Please check your email',
        backgroundColor: Colors.green,
        colorText: const Color.fromARGB(255, 255, 255, 255),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email.';
          break;

        default:
          message = 'Password reset failed. Please try again.';
      }

      Get.snackbar('Password Reset Error', message);
    }
  }
}
