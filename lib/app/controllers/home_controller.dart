import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class CommentModel {
  final String id;
  final String userName;
  final String text;
  final String timeAgo;

  CommentModel({
    required this.id,
    required this.userName,
    required this.text,
    required this.timeAgo,
  });
}

class PostModel {
  final String id;
  final String userName;
  final String userAvatar;
  final String content;
  final String? imageUrl;
  final String timeAgo;
  final RxInt likes;
  final RxInt comments;
  final RxInt shares;
  final RxBool isLiked;
  final RxList<CommentModel> commentsList;

  PostModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.content,
    this.imageUrl,
    required this.timeAgo,
    required int likesCount,
    required int commentsCount,
    required int sharesCount,
    bool liked = false,
    List<CommentModel>? initialComments,
  })  : likes = likesCount.obs,
        comments = commentsCount.obs,
        shares = sharesCount.obs,
        isLiked = liked.obs,
        commentsList = (initialComments ?? []).obs;
}

class StoryModel {
  final String id;
  final String userName;
  final String userAvatar;
  final String? storyImage;
  final bool isCreateStory;

  StoryModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    this.storyImage,
    this.isCreateStory = false,
  });
}

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var posts = <PostModel>[].obs;
  var stories = <StoryModel>[].obs;
  var searchQuery = ''.obs;
  var isSearching = false.obs;
  var filteredPosts = <PostModel>[].obs;
  
  final ImagePicker _picker = ImagePicker();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
    ever(searchQuery, (_) => filterPosts());
  }

  @override
  void onClose() {
    searchController.dispose();
    commentController.dispose();
    super.onClose();
  }

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }

  // Search functionality
  void startSearch() {
    isSearching.value = true;
  }

  void stopSearch() {
    isSearching.value = false;
    searchQuery.value = '';
    searchController.clear();
    filteredPosts.clear();
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void filterPosts() {
    if (searchQuery.value.isEmpty) {
      filteredPosts.clear();
      return;
    }
    
    filteredPosts.value = posts.where((post) {
      return post.userName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
             post.content.toLowerCase().contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  // Add new post with image
  Future<void> addNewPost() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (image != null) {
        final newPost = PostModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          userName: 'أنا',
          userAvatar: '',
          content: 'منشور جديد 📸',
          imageUrl: image.path,
          timeAgo: 'الآن',
          likesCount: 0,
          commentsCount: 0,
          sharesCount: 0,
        );
        
        posts.insert(0, newPost);
        
        Get.snackbar(
          'success'.tr,
          'تم إضافة المنشور بنجاح',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'حدث خطأ أثناء اختيار الصورة',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  // Create new story
  Future<void> createStory() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (image != null) {
        final newStory = StoryModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          userName: 'قصتي',
          userAvatar: '',
          storyImage: image.path,
        );
        
        // Insert after the "create story" card
        stories.insert(1, newStory);
        
        Get.snackbar(
          'success'.tr,
          'تم إضافة القصة بنجاح',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'حدث خطأ أثناء اختيار الصورة',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  // Open Messenger app
  Future<void> openMessenger() async {
    // Try to open Facebook Messenger
    final Uri messengerUrl = Uri.parse('fb-messenger://');
    final Uri messengerPlayStore = Uri.parse('https://play.google.com/store/apps/details?id=com.facebook.orca');
    
    try {
      if (await canLaunchUrl(messengerUrl)) {
        await launchUrl(messengerUrl, mode: LaunchMode.externalApplication);
      } else {
        // If Messenger is not installed, open Play Store
        if (await canLaunchUrl(messengerPlayStore)) {
          await launchUrl(messengerPlayStore, mode: LaunchMode.externalApplication);
        } else {
          Get.snackbar(
            'messages'.tr,
            'لم يتم العثور على تطبيق الماسنجر',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF242526),
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'تعذر فتح الماسنجر',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  // Share post
  Future<void> sharePost(PostModel post) async {
    try {
      await Share.share(
        '${post.userName}\n\n${post.content}\n\nتمت المشاركة من تطبيق Facebook Clone',
        subject: 'مشاركة منشور',
      );
      post.shares.value++;
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'تعذر مشاركة المنشور',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  // Show comments bottom sheet
  void showComments(PostModel post) {
    commentController.clear();
    
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        decoration: const BoxDecoration(
          color: Color(0xFF242526),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'comment'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF3A3B3C)),
            // Comments list
            Expanded(
              child: Obx(() => post.commentsList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.grey,
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'لا توجد تعليقات بعد',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'كن أول من يعلق!',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: post.commentsList.length,
                      itemBuilder: (context, index) {
                        final comment = post.commentsList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: Color(0xFF3A3B3C),
                                child: Icon(Icons.person, color: Colors.grey, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3A3B3C),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        comment.userName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        comment.text,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
            ),
            // Comment input
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF18191A),
                border: Border(
                  top: BorderSide(color: Color(0xFF3A3B3C)),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFF3A3B3C),
                    child: Icon(Icons.person, color: Colors.grey, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'اكتب تعليقاً...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        filled: true,
                        fillColor: const Color(0xFF3A3B3C),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => addComment(post),
                    icon: const Icon(Icons.send, color: Color(0xFF1877F2)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void addComment(PostModel post) {
    if (commentController.text.trim().isEmpty) return;
    
    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userName: 'أنا',
      text: commentController.text.trim(),
      timeAgo: 'الآن',
    );
    
    post.commentsList.add(newComment);
    post.comments.value++;
    commentController.clear();
    
    Get.snackbar(
      'success'.tr,
      'تم إضافة التعليق',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }

  void loadDummyData() {
    // Load dummy stories
    stories.value = [
      StoryModel(
        id: '0',
        userName: 'create_story'.tr,
        userAvatar: '',
        isCreateStory: true,
      ),
      StoryModel(
        id: '1',
        userName: 'محمد الزمر',
        userAvatar: '',
        storyImage: '',
      ),
      StoryModel(
        id: '2',
        userName: 'Mohamed Emam',
        userAvatar: '',
        storyImage: '',
      ),
      StoryModel(
        id: '3',
        userName: 'أحمد سعيد',
        userAvatar: '',
        storyImage: '',
      ),
    ];

    // Load dummy posts with sample comments
    posts.value = [
      PostModel(
        id: '1',
        userName: 'أحمد سعيد الأمير',
        userAvatar: '',
        content: '✨ *إشراقة صباحية*✨\n📆 السبت ١٣ - ٨ - ١٤٤٧هـ\nاللّهُم في هذا الصباح..يسّر حال من تعسّر ..وفرج هَمّ من ضاقت عليه الدنيا ..ووفقنا لما تحبه وترضاه. صباح الخير 🌹 اذكار الصباح',
        timeAgo: '2 ساعات',
        likesCount: 7,
        commentsCount: 2,
        sharesCount: 0,
        initialComments: [
          CommentModel(id: '1', userName: 'محمد', text: 'صباح النور 🌹', timeAgo: '1 ساعة'),
          CommentModel(id: '2', userName: 'علي', text: 'اللهم آمين', timeAgo: '30 دقيقة'),
        ],
      ),
      PostModel(
        id: '2',
        userName: 'الطهامي',
        userAvatar: '',
        content: 'كل شيء ممكن الا هذا ولا فهمت ايش راح يسوي بالجزيرة حتى لسان مافيش 😊 الله لا يبلانا بس',
        timeAgo: '8 ساعات',
        likesCount: 15,
        commentsCount: 3,
        sharesCount: 2,
        initialComments: [
          CommentModel(id: '3', userName: 'خالد', text: 'هههههه صح كلامك', timeAgo: '7 ساعات'),
        ],
      ),
      PostModel(
        id: '3',
        userName: 'محمد علي',
        userAvatar: '',
        content: 'الحمد لله على نعمة الإسلام وكفى بها نعمة 🤲',
        timeAgo: '1 ساعة',
        likesCount: 25,
        commentsCount: 5,
        sharesCount: 3,
      ),
    ];
  }

  void toggleLike(PostModel post) {
    if (post.isLiked.value) {
      post.likes.value--;
    } else {
      post.likes.value++;
    }
    post.isLiked.toggle();
  }
}
