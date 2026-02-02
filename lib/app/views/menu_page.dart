import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_menu_controller.dart';
import '../controllers/language_controller.dart';
import '../controllers/auth_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/menu_item_card.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppMenuController controller = Get.find<AppMenuController>();
    final LanguageController langController = Get.find<LanguageController>();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'menu'.tr,
          style: const TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.iconColor),
            onPressed: () {
              Get.snackbar('search'.tr, 'البحث في القائمة',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppTheme.cardColor,
                  colorText: AppTheme.textPrimaryColor);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.iconColor),
            onPressed: controller.goToSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.snackbar('الملف الشخصي', 'فتح الملف الشخصي',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppTheme.cardColor,
                              colorText: AppTheme.textPrimaryColor);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.keyboard_arrow_down,
                              color: AppTheme.iconColor),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'عاهد ابواصبع',
                            style: TextStyle(
                              color: AppTheme.textPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppTheme.surfaceColor,
                        child: Icon(Icons.person, color: AppTheme.iconColor),
                      ),
                    ],
                  ),
                  const Divider(height: 24, color: AppTheme.dividerColor),
                  InkWell(
                    onTap: () {
                      Get.snackbar('create_page'.tr, 'إنشاء صفحة جديدة',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppTheme.cardColor,
                          colorText: AppTheme.textPrimaryColor);
                    },
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          'create_page'.tr,
                          style: const TextStyle(
                            color: AppTheme.textPrimaryColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppTheme.surfaceColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add,
                              color: AppTheme.textPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Your Shortcuts
            Text(
              'your_shortcuts'.tr,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
            const SizedBox(height: 12),
            // Menu Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.8,
              ),
              itemCount: controller.menuItems.length,
              itemBuilder: (context, index) {
                final item = controller.menuItems[index];
                return MenuItemCard(
                  item: item,
                  onTap: () => controller.onMenuItemTap(item),
                );
              },
            ),
            const SizedBox(height: 8),
            // See More Button
            Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'see_more'.tr,
                  style: const TextStyle(
                    color: AppTheme.textPrimaryColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Settings Sections
            ...controller.settingsItems.map((item) => _buildSettingsItem(
                  item.icon,
                  item.titleKey.tr,
                  () => controller.onMenuItemTap(item),
                )),
            const SizedBox(height: 16),
            // Language Toggle
            _buildSettingsItem(
              Icons.language,
              'change_language'.tr,
              () => langController.toggleLanguage(),
              trailing: Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  langController.isArabic ? 'English' : 'العربية',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
            ),
            const SizedBox(height: 16),
            // Logout Button
            InkWell(
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    backgroundColor: AppTheme.cardColor,
                    title: Text(
                      'logout'.tr,
                      style: const TextStyle(color: AppTheme.textPrimaryColor),
                    ),
                    content: Text(
                      'logout_confirm'.tr,
                      style: const TextStyle(color: AppTheme.textSecondaryColor),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text('cancel'.tr),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          final authController = Get.find<AuthController>();
                          authController.logout();
                        },
                        child: Text(
                          'logout'.tr,
                          style: const TextStyle(color: AppTheme.redColor),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'logout'.tr,
                      style: const TextStyle(
                        color: AppTheme.redColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.logout, color: AppTheme.redColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, VoidCallback onTap,
      {Widget? trailing}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          children: [
            trailing ?? const Icon(Icons.chevron_left, color: AppTheme.iconColor),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppTheme.surfaceColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.iconColor, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
