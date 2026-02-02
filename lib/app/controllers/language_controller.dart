import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  // Current locale
  var currentLocale = const Locale('ar').obs;

  // Available locales
  final List<Map<String, dynamic>> locales = [
    {'name': 'العربية', 'locale': const Locale('ar')},
    {'name': 'English', 'locale': const Locale('en')},
  ];

  @override
  void onInit() {
    super.onInit();
    // Set Arabic as default
    currentLocale.value = const Locale('ar');
  }

  void changeLocale(Locale locale) {
    currentLocale.value = locale;
    Get.updateLocale(locale);
    Get.snackbar(
      'success'.tr,
      'language_changed'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void toggleLanguage() {
    if (currentLocale.value.languageCode == 'ar') {
      changeLocale(const Locale('en'));
    } else {
      changeLocale(const Locale('ar'));
    }
  }

  bool get isArabic => currentLocale.value.languageCode == 'ar';
}
