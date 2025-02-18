import 'package:get/get.dart';

import '../../../../router/app_routes.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 5000), () {
      Get.offNamed(AppRoutes.welcomeScreen);
    });
  }
}