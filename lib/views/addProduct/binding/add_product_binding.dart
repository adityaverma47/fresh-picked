import 'package:fresh_picked/core/app_export.dart';
import '../controller/add_product_controller.dart';

class AddProductBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController());
  }
}