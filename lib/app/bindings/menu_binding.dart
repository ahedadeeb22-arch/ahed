import 'package:get/get.dart';
import '../controllers/app_menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppMenuController>(() => AppMenuController());
  }
}
