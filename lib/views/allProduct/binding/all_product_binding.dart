import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/views/allProduct/controller/all_product_controller.dart';

class AllProductBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => AllProductController());
  }

}