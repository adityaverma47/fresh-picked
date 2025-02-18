import 'package:fresh_picked/views/forgotPassword/emailPage/controller/forgot_email_controller.dart';
import 'package:get/get.dart';

class ForgotEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>ForgotEmailController());
  }

}