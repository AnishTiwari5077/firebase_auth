import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final _auth = FirebaseAuth.instance;

  final RxBool _isFirstTime = true.obs;
  final Rxn<User> _user = Rxn<User>();

  bool get isFirstTime => _isFirstTime.value;
  bool get isLoggedIn => _user.value != null;
  User? get user => _user.value;

  get isLoading => null;

  @override
  void onInit() {
    super.onInit();
    _isFirstTime.value = _storage.read('isFirstTime') ?? true;
    _user.bindStream(_auth.authStateChanges());
  }

  void setFirstTimeDone() {
    _isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Login Success', 'Welcome back!');
    } catch (e) {
      Get.snackbar(
        'Login Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Register Success', 'Account created!');
    } catch (e) {
      Get.snackbar(
        'Register Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.snackbar('Logged Out', 'You have been signed out');
  }
}
