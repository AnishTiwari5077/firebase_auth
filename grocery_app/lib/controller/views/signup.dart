import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controller/controller_state.dart';
import 'package:grocery_app/controller/utils/apptext_style.dart';
import 'package:grocery_app/controller/views/sign_in.dart';
import 'package:grocery_app/controller/views/widgets/custom_textfield.dart';
import 'package:grocery_app/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final authController = Get.find<AuthController>();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      try {
        await authController.register(email, password);
        Get.off(() => HomeScreen());
      } catch (e) {
        Get.snackbar(
          'Signup Failed',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Create Account',
                  style: AppTextstyle.withcolor(
                    AppTextstyle.h1,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'sign up to get started',
                  style: AppTextstyle.withcolor(
                    AppTextstyle.bodyLarge,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextfield(
                  label: 'Full Name',
                  prefixIcon: Icons.person_outlined,
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextfield(
                  label: 'Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'please enter a valid email';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextfield(
                  label: 'password',

                  prefixIcon: Icons.lock_outline,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextfield(
                  label: 'confirm password',
                  prefixIcon: Icons.lock_outline,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm  your password';
                    }
                    if (value != _passwordController.text) {
                      return 'passwords do not match';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'sign up',
                      style: AppTextstyle.withcolor(
                        AppTextstyle.buttonMedium,
                        Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Alreay have an account ?',
                      style: AppTextstyle.withcolor(
                        AppTextstyle.bodyMedium,
                        isDark ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.off(() => SigninScreen()),
                      child: Text(
                        'sign In',
                        style: AppTextstyle.withcolor(
                          AppTextstyle.bodyMedium,
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
