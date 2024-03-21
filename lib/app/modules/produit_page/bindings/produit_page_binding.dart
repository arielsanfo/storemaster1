import 'package:get/get.dart';

import '../controllers/produit_page_controller.dart';

class ProduitPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProduitPageController>(
      () => ProduitPageController(),
    );
  }
}
