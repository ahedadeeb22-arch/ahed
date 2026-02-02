import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';
import '../theme/app_theme.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationsController controller =
        Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'notifications'.tr,
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
              Get.snackbar('search'.tr, 'البحث في الإشعارات',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppTheme.cardColor,
                  colorText: AppTheme.textPrimaryColor);
            },
          ),
          IconButton(
            icon: const Icon(Icons.done_all, color: AppTheme.iconColor),
            onPressed: controller.markAllAsRead,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.loadNotifications();
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              // New Notifications
              if (controller.unreadNotifications.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'new_notifications'.tr,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...controller.unreadNotifications.map(
                  (notification) => _buildNotificationTile(
                    notification,
                    controller,
                    isNew: true,
                  ),
                ),
              ],
              // Earlier Notifications
              if (controller.readNotifications.isNotEmpty) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'earlier'.tr,
                    style: const TextStyle(
                      color: AppTheme.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...controller.readNotifications.map(
                  (notification) => _buildNotificationTile(
                    notification,
                    controller,
                    isNew: false,
                  ),
                ),
              ],
              const SizedBox(height: 100),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildNotificationTile(
    NotificationModel notification,
    NotificationsController controller, {
    required bool isNew,
  }) {
    return InkWell(
      onTap: () => controller.onNotificationTap(notification),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: isNew
            ? AppTheme.primaryColor.withValues(alpha: 0.1)
            : Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // More Options
            IconButton(
              icon: const Icon(Icons.more_horiz, color: AppTheme.iconColor),
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.done,
                              color: AppTheme.iconColor),
                          title: Text(
                            'mark_as_read'.tr,
                            style: const TextStyle(
                                color: AppTheme.textPrimaryColor),
                          ),
                          onTap: () {
                            controller.markAsRead(notification);
                            Get.back();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete_outline,
                              color: AppTheme.redColor),
                          title: const Text(
                            'حذف الإشعار',
                            style: TextStyle(color: AppTheme.textPrimaryColor),
                          ),
                          onTap: () {
                            Get.back();
                            Get.snackbar('حذف', 'تم حذف الإشعار',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppTheme.cardColor,
                                colorText: AppTheme.textPrimaryColor);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: notification.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${notification.body}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.timeAgo,
                    style: TextStyle(
                      color: isNew
                          ? AppTheme.primaryColor
                          : AppTheme.textSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Avatar with Badge
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppTheme.surfaceColor,
                  child: const Icon(Icons.person, color: AppTheme.iconColor, size: 28),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _getNotificationColor(notification.type),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.backgroundColor,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      _getNotificationIcon(notification.type),
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.like:
        return Icons.thumb_up;
      case NotificationType.comment:
        return Icons.comment;
      case NotificationType.friendRequest:
        return Icons.person_add;
      case NotificationType.mention:
        return Icons.alternate_email;
      case NotificationType.share:
        return Icons.share;
      case NotificationType.birthday:
        return Icons.cake;
      case NotificationType.memory:
        return Icons.history;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.like:
        return AppTheme.primaryColor;
      case NotificationType.comment:
        return AppTheme.greenColor;
      case NotificationType.friendRequest:
        return Colors.purple;
      case NotificationType.mention:
        return Colors.orange;
      case NotificationType.share:
        return Colors.teal;
      case NotificationType.birthday:
        return Colors.pink;
      case NotificationType.memory:
        return Colors.amber;
    }
  }
}
