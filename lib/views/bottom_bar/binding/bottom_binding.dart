import 'package:fresh_picked/core/app_export.dart';
import '../controller/bottom_controller.dart';

class BottomBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => BottomController());
  }

}