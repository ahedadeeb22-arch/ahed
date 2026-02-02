import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum NotificationType {
  like,
  comment,
  friendRequest,
  mention,
  share,
  birthday,
  memory,
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String userAvatar;
  final String timeAgo;
  final NotificationType type;
  final RxBool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userAvatar,
    required this.timeAgo,
    required this.type,
    bool read = false,
  }) : isRead = read.obs;
}

class NotificationsController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    isLoading.value = true;
    
    Future.delayed(const Duration(milliseconds: 500), () {
      notifications.value = [
        NotificationModel(
          id: '1',
          title: 'أحمد سعيد',
          body: 'أعجب بمنشورك',
          userAvatar: '',
          timeAgo: '5 دقائق',
          type: NotificationType.like,
        ),
        NotificationModel(
          id: '2',
          title: 'محمد الزمر',
          body: 'علق على صورتك: "ما شاء الله"',
          userAvatar: '',
          timeAgo: '15 دقيقة',
          type: NotificationType.comment,
        ),
        NotificationModel(
          id: '3',
          title: 'سامي العلي',
          body: 'أرسل لك طلب صداقة',
          userAvatar: '',
          timeAgo: '1 ساعة',
          type: NotificationType.friendRequest,
        ),
        NotificationModel(
          id: '4',
          title: 'الطهامي',
          body: 'أشار إليك في تعليق',
          userAvatar: '',
          timeAgo: '2 ساعات',
          type: NotificationType.mention,
          read: true,
        ),
        NotificationModel(
          id: '5',
          title: 'ذكريات',
          body: 'لديك ذكريات جديدة لمشاركتها',
          userAvatar: '',
          timeAgo: '3 ساعات',
          type: NotificationType.memory,
          read: true,
        ),
        NotificationModel(
          id: '6',
          title: 'أعياد الميلاد',
          body: 'اليوم عيد ميلاد 3 من أصدقائك',
          userAvatar: '',
          timeAgo: '5 ساعات',
          type: NotificationType.birthday,
          read: true,
        ),
        NotificationModel(
          id: '7',
          title: 'خالد محمد',
          body: 'شارك منشورك',
          userAvatar: '',
          timeAgo: '8 ساعات',
          type: NotificationType.share,
          read: true,
        ),
      ];
      isLoading.value = false;
    });
  }

  void onNotificationTap(NotificationModel notification) {
    notification.isRead.value = true;
    
    Get.snackbar(
      'notification_opened'.tr,
      notification.body,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF242526),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      icon: Icon(_getNotificationIcon(notification.type), color: Colors.blue),
    );
  }

  void markAsRead(NotificationModel notification) {
    notification.isRead.value = true;
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification.isRead.value = true;
    }
    Get.snackbar(
      'success'.tr,
      'mark_as_read'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  List<NotificationModel> get unreadNotifications =>
      notifications.where((n) => !n.isRead.value).toList();

  List<NotificationModel> get readNotifications =>
      notifications.where((n) => n.isRead.value).toList();

  int get unreadCount => unreadNotifications.length;

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
