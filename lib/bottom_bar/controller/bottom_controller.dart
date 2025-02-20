import 'package:fresh_picked/core/app_export.dart';

class BottomController extends GetxController {

  var tabIndex = 0.obs;
  Rx<DateTime> lastTime = DateTime.now().obs;
  RxInt numberClick = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

}