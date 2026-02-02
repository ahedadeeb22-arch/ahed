import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/app_menu_controller.dart';
import '../controllers/notifications_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/story_card.dart';
import '../widgets/post_card.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'notifications_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(AppMenuController());
    Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Obx(() {
        switch (homeController.currentNavIndex.value) {
          case 0:
            return const HomeContent();
          case 1:
            return _buildPlaceholder('reels'.tr, Icons.play_circle_outline);
          case 2:
            return _buildPlaceholder('friends'.tr, Icons.people_outline);
          case 3:
            return _buildPlaceholder('groups'.tr, Icons.groups_outlined);
          case 4:
            return const NotificationsPage();
          case 5:
            return const ProfilePage();
          default:
            return const HomeContent();
        }
      }),
      bottomNavigationBar: Obx(() => Container(
        decoration: const BoxDecoration(
          color: AppTheme.backgroundColor,
          border: Border(
            top: BorderSide(color: AppTheme.dividerColor, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: homeController.currentNavIndex.value,
          onTap: homeController.changeNavIndex,
          backgroundColor: AppTheme.backgroundColor,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.iconColor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: 'nav_home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.play_circle_outline),
              activeIcon: const Icon(Icons.play_circle),
              label: 'nav_reels'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.people_outline),
              activeIcon: const Icon(Icons.people),
              label: 'nav_friends'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.groups_outlined),
              activeIcon: const Icon(Icons.groups),
              label: 'nav_groups'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications_outlined),
              activeIcon: const Icon(Icons.notifications),
              label: 'nav_notifications'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: 'nav_profile'.tr,
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildPlaceholder(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: AppTheme.iconColor),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Obx(() => controller.isSearching.value
            ? _buildSearchAppBar(controller)
            : _buildNormalAppBar(controller)),
      ),
      body: Obx(() => controller.isSearching.value
          ? _buildSearchResults(controller)
          : _buildMainContent(controller)),
    );
  }

  AppBar _buildNormalAppBar(HomeController controller) {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      title: const Text(
        'facebook',
        style: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -1,
        ),
      ),
      actions: [
        // Add Post Button
        _buildAppBarIcon(Icons.add_circle_outline, () {
          controller.addNewPost();
        }),
        // Search Button
        _buildAppBarIcon(Icons.search, () {
          controller.startSearch();
        }),
        // Messages Button - Opens Messenger
        _buildAppBarIcon(Icons.chat_bubble_outline, () {
          controller.openMessenger();
        }),
        // Menu Button
        InkWell(
          onTap: () {
            Get.to(() => const MenuPage());
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: const Icon(Icons.menu, color: AppTheme.iconColor),
          ),
        ),
      ],
    );
  }

  AppBar _buildSearchAppBar(HomeController controller) {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
        onPressed: () => controller.stopSearch(),
      ),
      title: TextField(
        controller: controller.searchController,
        autofocus: true,
        style: const TextStyle(color: AppTheme.textPrimaryColor),
        decoration: InputDecoration(
          hintText: 'search'.tr + '...',
          hintStyle: const TextStyle(color: AppTheme.textSecondaryColor),
          border: InputBorder.none,
        ),
        onChanged: controller.updateSearch,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close, color: AppTheme.iconColor),
          onPressed: () {
            controller.searchController.clear();
            controller.updateSearch('');
          },
        ),
      ],
    );
  }

  Widget _buildSearchResults(HomeController controller) {
    return Obx(() {
      if (controller.searchQuery.value.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search, size: 64, color: AppTheme.iconColor),
              const SizedBox(height: 16),
              Text(
                'ابحث عن منشورات أو أشخاص',
                style: TextStyle(color: AppTheme.textSecondaryColor, fontSize: 16),
              ),
            ],
          ),
        );
      }

      if (controller.filteredPosts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off, size: 64, color: AppTheme.iconColor),
              const SizedBox(height: 16),
              Text(
                'لا توجد نتائج لـ "${controller.searchQuery.value}"',
                style: const TextStyle(color: AppTheme.textSecondaryColor, fontSize: 16),
              ),
            ],
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: controller.filteredPosts.length,
        separatorBuilder: (context, index) => const Divider(
          height: 8,
          thickness: 8,
          color: AppTheme.cardColor,
        ),
        itemBuilder: (context, index) {
          final post = controller.filteredPosts[index];
          return PostCard(
            post: post,
            onLike: () => controller.toggleLike(post),
            onComment: () => controller.showComments(post),
            onShare: () => controller.sharePost(post),
          );
        },
      );
    });
  }

  Widget _buildMainContent(HomeController controller) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.loadDummyData();
      },
      child: ListView(
        children: [
          // Create Post Section
          Container(
            padding: const EdgeInsets.all(12),
            color: AppTheme.backgroundColor,
            child: Row(
              children: [
                InkWell(
                  onTap: () => controller.changeNavIndex(5),
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppTheme.surfaceColor,
                    child: Icon(Icons.person, color: AppTheme.iconColor),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => controller.addNewPost(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.dividerColor),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        'whats_on_your_mind'.tr,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),
          // Stories
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Obx(() => ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: controller.stories.length,
              itemBuilder: (context, index) {
                final story = controller.stories[index];
                return GestureDetector(
                  onTap: () {
                    if (story.isCreateStory) {
                      controller.createStory();
                    } else if (story.storyImage != null && story.storyImage!.isNotEmpty) {
                      // View story
                      _showStoryViewer(story);
                    }
                  },
                  child: StoryCard(story: story),
                );
              },
            )),
          ),
          const Divider(height: 8, thickness: 8, color: AppTheme.cardColor),
          // Posts
          Obx(() => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.posts.length,
            separatorBuilder: (context, index) => const Divider(
              height: 8,
              thickness: 8,
              color: AppTheme.cardColor,
            ),
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return PostCard(
                post: post,
                onLike: () => controller.toggleLike(post),
                onComment: () => controller.showComments(post),
                onShare: () => controller.sharePost(post),
              );
            },
          )),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  void _showStoryViewer(StoryModel story) {
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: AppTheme.surfaceColor,
                child: Icon(Icons.person, color: Colors.grey, size: 18),
              ),
              const SizedBox(width: 8),
              Text(
                story.userName,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
        body: Center(
          child: story.storyImage != null && File(story.storyImage!).existsSync()
              ? Image.file(
                  File(story.storyImage!),
                  fit: BoxFit.contain,
                )
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.primaries[story.id.hashCode % Colors.primaries.length],
                        Colors.black,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      story.userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildAppBarIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppTheme.iconColor, size: 22),
      ),
    );
  }
}
