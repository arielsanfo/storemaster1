import 'package:get/get.dart';

import '../controllers/commande_page_controller.dart';

class CommandePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommandePageController>(
      () => CommandePageController(),
    );
  }
}
