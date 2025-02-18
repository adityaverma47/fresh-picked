import 'package:fresh_picked/router/app_routes.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController{

  void navigateToLogin(){
    Get.toNamed(AppRoutes.loginScreen);
  }

  void navigateToRegister(){
    Get.toNamed(AppRoutes.registerScreen);
  }

}