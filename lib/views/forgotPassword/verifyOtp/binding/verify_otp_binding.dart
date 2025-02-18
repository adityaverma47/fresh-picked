import 'package:fresh_picked/views/forgotPassword/verifyOtp/controller/verify_otp_controller.dart';
import 'package:get/get.dart';

class ForgotVerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyOtpController());
  }

}