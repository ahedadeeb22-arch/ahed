import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isLoggedIn = false.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPhotoUrl = ''.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Email/Password Login
  Future<void> loginWithEmail() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    
    // Simulate login delay
    await Future.delayed(const Duration(seconds: 1));
    
    userName.value = emailController.text.split('@').first;
    userEmail.value = emailController.text;
    isLoggedIn.value = true;
    
    isLoading.value = false;
    
    Get.snackbar(
      'success'.tr,
      'login_success'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
    );
    
    Get.offAllNamed(AppRoutes.home);
  }

  // Google Sign In
  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser != null) {
        userName.value = googleUser.displayName ?? 'User';
        userEmail.value = googleUser.email;
        userPhotoUrl.value = googleUser.photoUrl ?? '';
        isLoggedIn.value = true;
        
        Get.snackbar(
          'success'.tr,
          'login_success'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
        );
        
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'login_error'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _googleSignIn.signOut();
    isLoggedIn.value = false;
    userName.value = '';
    userEmail.value = '';
    userPhotoUrl.value = '';
    emailController.clear();
    passwordController.clear();
    Get.offAllNamed(AppRoutes.login);
  }
}
