import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FriendModel {
  final String id;
  final String name;
  final String avatar;
  final int mutualFriends;

  FriendModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.mutualFriends,
  });
}

class ProfileController extends GetxController {
  var userName = 'عاهد أبو اصبع'.obs;
  var friendsCount = 818.obs;
  var postsCount = 0.obs;
  var bio = 'أصدقاء بينهم أمور مشتركة'.obs;
  var birthDate = '18 يوليو 2004'.obs;
  
  var profileImagePath = ''.obs;
  var coverImagePath = ''.obs;
  
  var selectedTab = 0.obs;
  var friends = <FriendModel>[].obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadDummyFriends();
  }

  void loadDummyFriends() {
    friends.value = [
      FriendModel(id: '1', name: 'محمد سامي', avatar: '', mutualFriends: 251),
      FriendModel(id: '2', name: 'Diaa Alzomor', avatar: '', mutualFriends: 345),
      FriendModel(id: '3', name: 'ابراهيم الشهاب', avatar: '', mutualFriends: 301),
      FriendModel(id: '4', name: 'Ameen Alzomor', avatar: '', mutualFriends: 30),
    ];
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  Future<void> pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (image != null) {
        profileImagePath.value = image.path;
        Get.snackbar(
          'success'.tr,
          'profile_updated'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  Future<void> pickCoverImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      
      if (image != null) {
        coverImagePath.value = image.path;
        Get.snackbar(
          'success'.tr,
          'profile_updated'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  void addToStory() {
    Get.snackbar(
      'success'.tr,
      'story_added'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void editProfile() {
    Get.snackbar(
      'edit_profile'.tr,
      'profile_updated'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  ImageProvider? get profileImage {
    if (profileImagePath.value.isNotEmpty) {
      return FileImage(File(profileImagePath.value));
    }
    return null;
  }

  ImageProvider? get coverImage {
    if (coverImagePath.value.isNotEmpty) {
      return FileImage(File(coverImagePath.value));
    }
    return null;
  }
}
