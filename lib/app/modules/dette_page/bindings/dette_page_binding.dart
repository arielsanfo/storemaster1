import 'package:get/get.dart';

import '../controllers/dette_page_controller.dart';

class DettePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DettePageController>(
      () => DettePageController(),
    );
  }
}
