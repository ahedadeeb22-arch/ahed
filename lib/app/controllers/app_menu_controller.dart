import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import 'language_controller.dart';

class MenuItemModel {
  final String titleKey;
  final IconData icon;
  final String? route;
  final VoidCallback? onTap;

  MenuItemModel({
    required this.titleKey,
    required this.icon,
    this.route,
    this.onTap,
  });
}

class AppMenuController extends GetxController {
  final LanguageController languageController = Get.find<LanguageController>();

  List<MenuItemModel> get menuItems => [
        MenuItemModel(
          titleKey: 'memories',
          icon: Icons.history,
          route: AppRoutes.memories,
        ),
        MenuItemModel(
          titleKey: 'saved_items',
          icon: Icons.bookmark_outline,
          onTap: () => _showSnackbar('saved_items'.tr),
        ),
        MenuItemModel(
          titleKey: 'groups',
          icon: Icons.groups_outlined,
          onTap: () => _showSnackbar('groups'.tr),
        ),
        MenuItemModel(
          titleKey: 'reels',
          icon: Icons.play_circle_outline,
          onTap: () => _showSnackbar('reels'.tr),
        ),
        MenuItemModel(
          titleKey: 'marketplace',
          icon: Icons.storefront_outlined,
          onTap: () => _showSnackbar('marketplace'.tr),
        ),
        MenuItemModel(
          titleKey: 'friends',
          icon: Icons.people_outline,
          onTap: () => _showSnackbar('friends'.tr),
        ),
        MenuItemModel(
          titleKey: 'events',
          icon: Icons.event_outlined,
          onTap: () => _showSnackbar('events'.tr),
        ),
        MenuItemModel(
          titleKey: 'news',
          icon: Icons.newspaper_outlined,
          onTap: () => _showSnackbar('news'.tr),
        ),
      ];

  List<MenuItemModel> get settingsItems => [
        MenuItemModel(
          titleKey: 'help_support',
          icon: Icons.help_outline,
          onTap: () => _showSnackbar('help_support'.tr),
        ),
        MenuItemModel(
          titleKey: 'settings_privacy',
          icon: Icons.settings_outlined,
          route: AppRoutes.settings,
        ),
        MenuItemModel(
          titleKey: 'professional_access',
          icon: Icons.workspace_premium_outlined,
          onTap: () => _showSnackbar('professional_access'.tr),
        ),
      ];

  void onMenuItemTap(MenuItemModel item) {
    if (item.route != null) {
      Get.toNamed(item.route!);
    } else if (item.onTap != null) {
      item.onTap!();
    }
  }

  void toggleLanguage() {
    languageController.toggleLanguage();
  }

  void _showSnackbar(String message) {
    Get.snackbar(
      message,
      'تم النقر',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF242526),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void goToMemories() {
    Get.toNamed(AppRoutes.memories);
  }

  void goToSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  void goToNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }
}
