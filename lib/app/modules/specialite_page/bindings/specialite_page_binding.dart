
import 'package:ArielSchool/app/modules/specialite_page/views/specialite_page_view.dart';
// import 'package:ArielSchool/app/modules/home/views/drawer.dart';
import 'package:get/get.dart';

class SpecialitePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<specialite>(
      () => specialite(),
    );
  }
}
