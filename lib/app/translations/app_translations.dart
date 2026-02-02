import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          // General
          'app_name': 'فيسبوك',
          'search': 'بحث',
          'settings': 'الإعدادات',
          'menu': 'القائمة',
          'see_more': 'عرض المزيد',
          'cancel': 'إلغاء',
          'save': 'حفظ',
          'done': 'تم',
          'error': 'خطأ',
          'success': 'نجاح',

          // Login
          'login': 'تسجيل الدخول',
          'email': 'البريد الإلكتروني',
          'password': 'كلمة المرور',
          'login_button': 'تسجيل الدخول',
          'continue_with_google': 'المتابعة باستخدام Google',
          'forgot_password': 'نسيت كلمة المرور؟',
          'create_account': 'إنشاء حساب جديد',
          'login_success': 'تم تسجيل الدخول بنجاح',
          'login_error': 'خطأ في تسجيل الدخول',

          // Home
          'home': 'الصفحة الرئيسية',
          'whats_on_your_mind': 'بم تفكر؟',
          'like': 'إعجاب',
          'comment': 'تعليق',
          'share': 'مشاركة',
          'liked': 'أعجبني',
          'create_story': 'إنشاء قصة',
          'hours_ago': 'منذ %s ساعات',
          'just_now': 'الآن',

          // Profile
          'profile': 'الملف الشخصي',
          'edit_profile': 'تعديل الملف الشخصي',
          'add_to_story': 'إضافة إلى القصة',
          'friends': 'الأصدقاء',
          'mutual_friends': 'أصدقاء مشتركون',
          'posts': 'المنشورات',
          'all': 'الكل',
          'photos': 'الصور',
          'reels': 'ريلز',
          'personal_details': 'التفاصيل الشخصية',
          'all_posts': 'كل المنشورات',
          'see_all': 'عرض الكل',
          'story_added': 'تمت إضافة القصة بنجاح',
          'profile_updated': 'تم تحديث الملف الشخصي',
          'select_image': 'اختر صورة',

          // Menu
          'memories': 'الذكريات',
          'saved_items': 'العناصر المحفوظة',
          'groups': 'المجموعات',
          'marketplace': 'Marketplace',
          'events': 'المناسبات',
          'news': 'الأخبار',
          'help_support': 'المساعدة والدعم',
          'settings_privacy': 'الإعدادات والخصوصية',
          'professional_access': 'الوصول الاحترافي',
          'create_page': 'إنشاء صفحة على فيسبوك',
          'your_shortcuts': 'اختصاراتك',
          'change_language': 'تغيير اللغة',
          'language_changed': 'تم تغيير اللغة',

          // Notifications
          'notifications': 'الإشعارات',
          'notification_opened': 'تم فتح الإشعار',
          'mark_as_read': 'تحديد كمقروء',
          'new_notifications': 'إشعارات جديدة',
          'earlier': 'سابقاً',

          // Memories
          'memories_title': 'ذكرياتك',
          'years_ago': 'منذ %s سنوات',
          'on_this_day': 'في مثل هذا اليوم',
          'memory_opened': 'تم فتح الذكرى',

          // Settings
          'profile_settings': 'إعدادات الملف الشخصي',
          'follow_settings': 'إعدادات المتابعة',
          'add_featured_posts': 'إضافة أبرز المنشورات',
          'profile_status': 'حالة الملف الشخصي',
          'verified_profile': 'إظهار أن ملفك الشخصي تم التحقق منه',
          'archive': 'الأرشيف',
          'view_as': 'عرض كما يظهر للآخرين',
          'lock_profile': 'قفل الملف الشخصي',
          'activity_log': 'سجل النشاطات',
          'tags_settings': 'إعدادات الإشارات والملف الشخصي',
          'review_posts': 'مراجعة المنشورات والإشارات',
          'privacy_center': 'مركز الخصوصية',
          'memorial_settings': 'إعدادات إحياء الذكرى',
          'professional_mode': 'تشغيل الوضع الاحترافي',

          // Bottom Navigation
          'nav_home': 'الصفحة الرئيسية',
          'nav_reels': 'ريلز',
          'nav_friends': 'الأصدقاء',
          'nav_groups': 'المجموعات',
          'nav_notifications': 'الإشعارات',
          'nav_profile': 'ملف شخصي',

          // Logout
          'logout': 'تسجيل الخروج',
          'logout_confirm': 'هل تريد تسجيل الخروج؟',
        },
        'en': {
          // General
          'app_name': 'Facebook',
          'search': 'Search',
          'settings': 'Settings',
          'menu': 'Menu',
          'see_more': 'See More',
          'cancel': 'Cancel',
          'save': 'Save',
          'done': 'Done',
          'error': 'Error',
          'success': 'Success',

          // Login
          'login': 'Login',
          'email': 'Email',
          'password': 'Password',
          'login_button': 'Log In',
          'continue_with_google': 'Continue with Google',
          'forgot_password': 'Forgot Password?',
          'create_account': 'Create New Account',
          'login_success': 'Login successful',
          'login_error': 'Login error',

          // Home
          'home': 'Home',
          'whats_on_your_mind': "What's on your mind?",
          'like': 'Like',
          'comment': 'Comment',
          'share': 'Share',
          'liked': 'Liked',
          'create_story': 'Create Story',
          'hours_ago': '%s hours ago',
          'just_now': 'Just now',

          // Profile
          'profile': 'Profile',
          'edit_profile': 'Edit Profile',
          'add_to_story': 'Add to Story',
          'friends': 'Friends',
          'mutual_friends': 'Mutual Friends',
          'posts': 'Posts',
          'all': 'All',
          'photos': 'Photos',
          'reels': 'Reels',
          'personal_details': 'Personal Details',
          'all_posts': 'All Posts',
          'see_all': 'See All',
          'story_added': 'Story added successfully',
          'profile_updated': 'Profile updated',
          'select_image': 'Select Image',

          // Menu
          'memories': 'Memories',
          'saved_items': 'Saved Items',
          'groups': 'Groups',
          'marketplace': 'Marketplace',
          'events': 'Events',
          'news': 'News',
          'help_support': 'Help & Support',
          'settings_privacy': 'Settings & Privacy',
          'professional_access': 'Professional Access',
          'create_page': 'Create a Page on Facebook',
          'your_shortcuts': 'Your Shortcuts',
          'change_language': 'Change Language',
          'language_changed': 'Language changed',

          // Notifications
          'notifications': 'Notifications',
          'notification_opened': 'Notification opened',
          'mark_as_read': 'Mark as read',
          'new_notifications': 'New',
          'earlier': 'Earlier',

          // Memories
          'memories_title': 'Your Memories',
          'years_ago': '%s years ago',
          'on_this_day': 'On This Day',
          'memory_opened': 'Memory opened',

          // Settings
          'profile_settings': 'Profile Settings',
          'follow_settings': 'Follow Settings',
          'add_featured_posts': 'Add Featured Posts',
          'profile_status': 'Profile Status',
          'verified_profile': 'Show your profile is verified',
          'archive': 'Archive',
          'view_as': 'View As',
          'lock_profile': 'Lock Profile',
          'activity_log': 'Activity Log',
          'tags_settings': 'Tags & Profile Settings',
          'review_posts': 'Review Posts & Tags',
          'privacy_center': 'Privacy Center',
          'memorial_settings': 'Memorial Settings',
          'professional_mode': 'Turn on Professional Mode',

          // Bottom Navigation
          'nav_home': 'Home',
          'nav_reels': 'Reels',
          'nav_friends': 'Friends',
          'nav_groups': 'Groups',
          'nav_notifications': 'Notifications',
          'nav_profile': 'Profile',

          // Logout
          'logout': 'Log Out',
          'logout_confirm': 'Do you want to log out?',
        },
      };
}
