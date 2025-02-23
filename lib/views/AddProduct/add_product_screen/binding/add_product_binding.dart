import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/views/AddProduct/add_product_screen/controller/add_product_controller.dart';

class AddProductBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController());
  }
}