import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_routes.dart';
import 'app/translations/app_translations.dart';
import 'app/theme/app_theme.dart';
import 'app/controllers/language_controller.dart';
import 'app/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart'; // استيراد المكتبة
// import 'firebase_options.dart';

void main() async {
  // إضافة السطرين التاليين ضرورية جداً لعمل الفايربيس
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    // طباعة رسالة النجاح في الـ Console
    print("✅ تم الاتصال بـ Firebase بنجاح!");
  } catch (e) {
    // في حال وجود خطأ في الإعدادات أو ملف json
    print("❌ فشل الاتصال بـ Firebase: $e");
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers that need to be available globally
    Get.put(LanguageController(), permanent: true);
    Get.put(AuthController(), permanent: true);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facebook Clone',
      
      // Theme
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      
      // Translations
      translations: AppTranslations(),
      locale: const Locale('ar'),
      fallbackLocale: const Locale('en'),
      
      // Routes
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
      
      // RTL Support
      builder: (context, child) {
        return Directionality(
          textDirection: Get.locale?.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}