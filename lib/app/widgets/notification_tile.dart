import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';
import '../theme/app_theme.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final bool isNew;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                Get.snackbar(
                  'خيارات',
                  'خيارات الإشعار',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppTheme.cardColor,
                  colorText: AppTheme.textPrimaryColor,
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
            // Avatar
            Stack(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: AppTheme.surfaceColor,
                  child: Icon(Icons.person, color: AppTheme.iconColor, size: 28),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
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
}
