import 'package:get/get.dart';
import '../views/splash_screen.dart';
import '../views/login_page.dart';
import '../views/home_page.dart';
import '../views/profile_page.dart';
import '../views/menu_page.dart';
import '../views/memories_page.dart';
import '../views/notifications_page.dart';
import '../views/settings_page.dart';
import '../bindings/login_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/menu_binding.dart';
import '../bindings/memories_binding.dart';
import '../bindings/notifications_binding.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String menu = '/menu';
  static const String memories = '/memories';
  static const String notifications = '/notifications';
  static const String settings = '/settings';

  static List<GetPage> get pages => [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(
      name: login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(name: home, page: () => const HomePage(), binding: HomeBinding()),
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(name: menu, page: () => const MenuPage(), binding: MenuBinding()),
    GetPage(
      name: memories,
      page: () => const MemoriesPage(),
      binding: MemoriesBinding(),
    ),
    GetPage(
      name: notifications,
      page: () => const NotificationsPage(),
      binding: NotificationsBinding(),
    ),
    GetPage(name: settings, page: () => const SettingsPage()),
  ];
}
