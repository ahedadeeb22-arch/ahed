import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'profile_settings'.tr,
          style: const TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildSettingsItem(
            Icons.person_add_outlined,
            'follow_settings'.tr,
          ),
          _buildSettingsItem(
            Icons.star_outline,
            'add_featured_posts'.tr,
          ),
          _buildSettingsItem(
            Icons.circle_outlined,
            'profile_status'.tr,
          ),
          _buildSettingsItem(
            Icons.verified_outlined,
            'verified_profile'.tr,
          ),
          _buildSettingsItem(
            Icons.archive_outlined,
            'archive'.tr,
          ),
          _buildSettingsItem(
            Icons.visibility_outlined,
            'view_as'.tr,
          ),
          _buildSettingsItem(
            Icons.lock_outline,
            'lock_profile'.tr,
          ),
          _buildSettingsItem(
            Icons.list_alt,
            'activity_log'.tr,
          ),
          _buildSettingsItem(
            Icons.alternate_email,
            'tags_settings'.tr,
          ),
          _buildSettingsItem(
            Icons.rate_review_outlined,
            'review_posts'.tr,
          ),
          _buildSettingsItem(
            Icons.security_outlined,
            'privacy_center'.tr,
          ),
          _buildSettingsItem(
            Icons.search,
            'search'.tr,
          ),
          _buildSettingsItem(
            Icons.favorite_outline,
            'memorial_settings'.tr,
          ),
          _buildSettingsItem(
            Icons.workspace_premium_outlined,
            'professional_mode'.tr,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title) {
    return InkWell(
      onTap: () {
        Get.snackbar(
          title,
          'تم النقر على الإعداد',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppTheme.cardColor,
          colorText: AppTheme.textPrimaryColor,
          duration: const Duration(seconds: 2),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppTheme.dividerColor, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.chevron_left, color: AppTheme.iconColor),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 16),
            Icon(icon, color: AppTheme.iconColor),
          ],
        ),
      ),
    );
  }
}
