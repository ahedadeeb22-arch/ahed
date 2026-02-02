import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../theme/app_theme.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
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
                              leading: const Icon(Icons.bookmark_outline,
                                  color: AppTheme.iconColor),
                              title: Text(
                                'حفظ المنشور',
                                style: const TextStyle(
                                    color: AppTheme.textPrimaryColor),
                              ),
                              onTap: () => Get.back(),
                            ),
                            ListTile(
                              leading: const Icon(Icons.hide_source,
                                  color: AppTheme.iconColor),
                              title: const Text(
                                'إخفاء المنشور',
                                style:
                                    TextStyle(color: AppTheme.textPrimaryColor),
                              ),
                              onTap: () => Get.back(),
                            ),
                            ListTile(
                              leading: const Icon(Icons.report_outlined,
                                  color: AppTheme.redColor),
                              title: const Text(
                                'الإبلاغ عن المنشور',
                                style:
                                    TextStyle(color: AppTheme.textPrimaryColor),
                              ),
                              onTap: () => Get.back(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        post.userName,
                        style: const TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.public,
                              color: AppTheme.textSecondaryColor, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            post.timeAgo,
                            style: const TextStyle(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: AppTheme.surfaceColor,
                  child: Icon(Icons.person, color: AppTheme.iconColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              post.content,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 15,
                height: 1.4,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          // Image if exists
          if (post.imageUrl != null && post.imageUrl!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildPostImage(),
          ],
          const SizedBox(height: 12),
          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Obx(() => Row(
                  children: [
                    if (post.shares.value > 0)
                      Text(
                        '${post.shares.value} ' + 'share'.tr,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 13,
                        ),
                      ),
                    if (post.comments.value > 0) ...[
                      const SizedBox(width: 16),
                      Text(
                        '${post.comments.value} ' + 'comment'.tr,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                    const Spacer(),
                    if (post.likes.value > 0)
                      Row(
                        children: [
                          Text(
                            '${post.likes.value}',
                            style: const TextStyle(
                              color: AppTheme.textSecondaryColor,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ],
                      ),
                  ],
                )),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: AppTheme.dividerColor),
          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  Icons.share_outlined,
                  'share'.tr,
                  onShare,
                  false,
                ),
                _buildActionButton(
                  Icons.chat_bubble_outline,
                  'comment'.tr,
                  onComment,
                  false,
                ),
                Obx(() => _buildActionButton(
                      post.isLiked.value
                          ? Icons.thumb_up
                          : Icons.thumb_up_outlined,
                      post.isLiked.value ? 'liked'.tr : 'like'.tr,
                      onLike,
                      post.isLiked.value,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, VoidCallback onTap, bool isActive) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? AppTheme.primaryColor
                    : AppTheme.textSecondaryColor,
                fontSize: 13,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              icon,
              color:
                  isActive ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    final file = File(post.imageUrl!);
    if (file.existsSync()) {
      return ClipRRect(
        child: Image.file(
          file,
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              width: double.infinity,
              color: AppTheme.surfaceColor,
              child: const Center(
                child: Icon(Icons.image, color: AppTheme.iconColor, size: 48),
              ),
            );
          },
        ),
      );
    }
    return Container(
      height: 200,
      width: double.infinity,
      color: AppTheme.surfaceColor,
      child: const Center(
        child: Icon(Icons.image, color: AppTheme.iconColor, size: 48),
      ),
    );
  }
}
