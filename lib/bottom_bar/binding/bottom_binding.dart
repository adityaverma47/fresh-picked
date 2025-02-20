import 'package:fresh_picked/bottom_bar/controller/bottom_controller.dart';
import 'package:fresh_picked/core/app_export.dart';

class BottomBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => BottomController());
  }

}