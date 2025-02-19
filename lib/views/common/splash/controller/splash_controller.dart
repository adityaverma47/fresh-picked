import 'package:get/get.dart';
import '../../../../router/app_routes.dart';

class SplashController extends GetxController {
  // Reactive variable
  var isSplashDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate splash screen time using a delayed method
    Future.delayed(const Duration(seconds: 3), () {
      isSplashDone.value = true; // Set to true after 3 seconds to trigger navigation
    });
  }
}
