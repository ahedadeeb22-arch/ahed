import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../theme/app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.facebook,
                  size: 55,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              // Title
              Text(
                'login'.tr,
                style: const TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              // Email Field
              TextField(
                controller: authController.emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: AppTheme.textPrimaryColor),
                decoration: InputDecoration(
                  hintText: 'email'.tr,
                  prefixIcon: const Icon(Icons.email_outlined, color: AppTheme.iconColor),
                ),
              ),
              const SizedBox(height: 16),
              // Password Field
              Obx(() => TextField(
                controller: authController.passwordController,
                obscureText: !authController.isPasswordVisible.value,
                style: const TextStyle(color: AppTheme.textPrimaryColor),
                decoration: InputDecoration(
                  hintText: 'password'.tr,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.iconColor),
                  suffixIcon: IconButton(
                    onPressed: authController.togglePasswordVisibility,
                    icon: Icon(
                      authController.isPasswordVisible.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppTheme.iconColor,
                    ),
                  ),
                ),
              )),
              const SizedBox(height: 12),
              // Forgot Password
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {
                    Get.snackbar(
                      'forgot_password'.tr,
                      'تم إرسال رابط إعادة تعيين كلمة المرور',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppTheme.cardColor,
                      colorText: AppTheme.textPrimaryColor,
                    );
                  },
                  child: Text(
                    'forgot_password'.tr,
                    style: const TextStyle(color: AppTheme.primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Login Button
              Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: authController.isLoading.value
                      ? null
                      : authController.loginWithEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: authController.isLoading.value
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'login_button'.tr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              )),
              const SizedBox(height: 24),
              // Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppTheme.dividerColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'أو',
                      style: const TextStyle(color: AppTheme.textSecondaryColor),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppTheme.dividerColor)),
                ],
              ),
              const SizedBox(height: 24),
              // Google Sign In
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: authController.loginWithGoogle,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.dividerColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  icon: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  label: Text(
                    'continue_with_google'.tr,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Create Account
              TextButton(
                onPressed: () {
                  Get.snackbar(
                    'create_account'.tr,
                    'سيتم توجيهك لصفحة إنشاء حساب',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppTheme.cardColor,
                    colorText: AppTheme.textPrimaryColor,
                  );
                },
                child: Text(
                  'create_account'.tr,
                  style: const TextStyle(
                    color: AppTheme.greenColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
