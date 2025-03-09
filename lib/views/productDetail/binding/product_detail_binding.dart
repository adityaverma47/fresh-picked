import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/views/productDetail/controller/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
  }
}
