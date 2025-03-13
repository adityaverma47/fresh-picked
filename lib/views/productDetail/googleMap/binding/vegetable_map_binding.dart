import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/views/productDetail/googleMap/controller/vegetable_map_controller.dart';

class VegetableMapBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => VegetableMapController());
  }

}