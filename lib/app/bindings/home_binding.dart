import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/app_menu_controller.dart';
import '../controllers/notifications_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AppMenuController>(() => AppMenuController());
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}
