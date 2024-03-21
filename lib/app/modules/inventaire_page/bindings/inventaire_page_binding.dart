import 'package:get/get.dart';

import '../controllers/inventaire_page_controller.dart';

class InventairePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventairePageController>(
      () => InventairePageController(),
    );
  }
}
