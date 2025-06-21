import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controller/utils/apptext_style.dart';
import 'package:grocery_app/controller/views/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
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
              SizedBox(height: 20),
              Text(
                'Reset password',
                style: AppTextstyle.withcolor(
                  AppTextstyle.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Enter your email to reset your password',
                style: AppTextstyle.withcolor(
                  AppTextstyle.bodyLarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              SizedBox(height: 40),
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
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showAboutDialog(context: context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Send reset link',
                    style: AppTextstyle.withcolor(
                      AppTextstyle.buttonMedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSucessDialog(BuildContext context) {
  Get.dialog(
    AlertDialog(
      title: Text('check your Email', style: AppTextstyle.h3),
      content: Text(
        'we have sent password recovery to your email',
        style: AppTextstyle.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'ok',
            style: AppTextstyle.withcolor(
              AppTextstyle.buttonMedium,
              Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}
