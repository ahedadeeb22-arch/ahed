import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
          controller.userName.value,
          style: const TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: 18,
          ),
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.iconColor),
            onPressed: () {
              Get.snackbar('search'.tr, 'البحث في الملف الشخصي',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppTheme.cardColor,
                  colorText: AppTheme.textPrimaryColor);
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: AppTheme.iconColor),
            onPressed: () {
              Get.snackbar('المزيد', 'خيارات إضافية',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppTheme.cardColor,
                  colorText: AppTheme.textPrimaryColor);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover and Profile Photo
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Cover Photo
                InkWell(
                  onTap: controller.pickCoverImage,
                  child: Obx(() => Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      image: controller.coverImage != null
                          ? DecorationImage(
                              image: controller.coverImage!,
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: controller.coverImage == null
                        ? const Icon(Icons.camera_alt,
                            color: AppTheme.iconColor, size: 40)
                        : null,
                  )),
                ),
                // Profile Photo
                Positioned(
                  bottom: -60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: InkWell(
                      onTap: controller.pickProfileImage,
                      child: Stack(
                        children: [
                          Obx(() => Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.backgroundColor,
                                width: 4,
                              ),
                              color: AppTheme.surfaceColor,
                              image: controller.profileImage != null
                                  ? DecorationImage(
                                      image: controller.profileImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: controller.profileImage == null
                                ? const Icon(Icons.person,
                                    color: AppTheme.iconColor, size: 60)
                                : null,
                          )),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppTheme.backgroundColor,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(Icons.camera_alt,
                                  color: AppTheme.textPrimaryColor, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // What's on your mind bubble
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'whats_on_your_mind'.tr,
                      style: const TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            // User Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Obx(() => Text(
                    controller.userName.value,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                    '${controller.friendsCount.value} ' + 'friends'.tr + ' • ${controller.postsCount.value} ' + 'posts'.tr,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 14,
                    ),
                  )),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                    controller.bio.value,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: controller.addToStory,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.add, color: Colors.white, size: 20),
                      label: Text(
                        'add_to_story'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: OutlinedButton.icon(
                      onPressed: controller.editProfile,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppTheme.surfaceColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.edit,
                          color: AppTheme.textPrimaryColor, size: 20),
                      label: Text(
                        'edit_profile'.tr,
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Tabs
            Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildTab(controller, 0, 'all'.tr),
                  const SizedBox(width: 8),
                  _buildTab(controller, 1, 'photos'.tr),
                  const SizedBox(width: 8),
                  _buildTab(controller, 2, 'reels'.tr),
                ],
              ),
            )),
            const Divider(height: 24, color: AppTheme.dividerColor),
            // Personal Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit,
                            color: AppTheme.iconColor, size: 20),
                        onPressed: () {},
                      ),
                      const Spacer(),
                      Text(
                        'personal_details'.tr,
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() => Text(
                        controller.birthDate.value,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 14,
                        ),
                      )),
                      const SizedBox(width: 8),
                      const Icon(Icons.cake, color: AppTheme.iconColor, size: 20),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 24, color: AppTheme.dividerColor),
            // Friends Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'see_all'.tr,
                          style: const TextStyle(color: AppTheme.primaryColor),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'friends'.tr,
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Obx(() => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: controller.friends.length,
                    itemBuilder: (context, index) {
                      final friend = controller.friends[index];
                      return InkWell(
                        onTap: () {
                          Get.snackbar(friend.name, '${friend.mutualFriends} ' + 'mutual_friends'.tr,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppTheme.cardColor,
                              colorText: AppTheme.textPrimaryColor);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.person,
                                  color: AppTheme.iconColor, size: 30),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              friend.name,
                              style: const TextStyle(
                                color: AppTheme.textPrimaryColor,
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                ],
              ),
            ),
            const Divider(height: 24, color: AppTheme.dividerColor),
            // All Posts Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'all_posts'.tr,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'whats_on_your_mind'.tr,
                            style: const TextStyle(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: AppTheme.surfaceColor,
                          child:
                              Icon(Icons.person, color: AppTheme.iconColor, size: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(ProfileController controller, int index, String label) {
    final isSelected = controller.selectedTab.value == index;
    return InkWell(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
