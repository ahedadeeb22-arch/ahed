import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoryModel {
  final String id;
  final String title;
  final String content;
  final String date;
  final String? imageUrl;
  final int yearsAgo;

  MemoryModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.imageUrl,
    required this.yearsAgo,
  });
}

class MemoriesController extends GetxController {
  var memories = <MemoryModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMemories();
  }

  void loadMemories() {
    isLoading.value = true;
    
    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      memories.value = [
        MemoryModel(
          id: '1',
          title: 'ذكرى من 3 سنوات',
          content: 'الحمد لله على كل شيء، يوم جميل من الماضي 🌟',
          date: '2 فبراير 2023',
          yearsAgo: 3,
        ),
        MemoryModel(
          id: '2',
          title: 'ذكرى من 5 سنوات',
          content: 'لحظات لا تُنسى مع الأصدقاء 💫',
          date: '2 فبراير 2021',
          yearsAgo: 5,
        ),
        MemoryModel(
          id: '3',
          title: 'ذكرى من سنة واحدة',
          content: 'بداية رحلة جديدة في الحياة 🚀',
          date: '2 فبراير 2025',
          yearsAgo: 1,
        ),
        MemoryModel(
          id: '4',
          title: 'ذكرى من 2 سنوات',
          content: 'صباح الخير من الماضي الجميل ☀️',
          date: '2 فبراير 2024',
          yearsAgo: 2,
        ),
        MemoryModel(
          id: '5',
          title: 'ذكرى من 4 سنوات',
          content: 'الأيام الجميلة لا تُنسى أبداً 🌺',
          date: '2 فبراير 2022',
          yearsAgo: 4,
        ),
      ];
      isLoading.value = false;
    });
  }

  void onMemoryTap(MemoryModel memory) {
    Get.snackbar(
      'memory_opened'.tr,
      memory.title,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF242526),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.history, color: Colors.blue),
    );
  }

  void shareMemory(MemoryModel memory) {
    Get.snackbar(
      'share'.tr,
      'تمت مشاركة الذكرى',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
