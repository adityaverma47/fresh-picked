import 'dart:async';
import 'package:fresh_picked/router/app_routes.dart';
import '../../../../core/app_export.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/dio_client.dart';
import '../../../../widgets/custom_snack_bar.dart';


class VerifyOtpController extends GetxController {

  RxBool isLoading = false.obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  final ApiService apiService = ApiService(dio: DioClient().getDio());
  final GetStorage storage = GetStorage();
  RxInt timeCounter = 60.obs;
  late Timer _timer;
  Map<String, dynamic>? argumentData;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    final receivedOtp = storage.read(Constants.forgotPasswordReceivedOtp);
    startTimer();
    if (kDebugMode) {
      print("Received otp: $receivedOtp");
    }
  }

  void navigateToPasswordScreen() {
    Get.toNamed(AppRoutes.newPasswordScreen);
  }

  Future<void> forgotPasswordVerifyOtp() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    isLoading.value = true;
    try {
      final receivedOtp = storage.read(Constants.forgotPasswordReceivedOtp);
      final enteredOtp = otpController.value.text.toString();

      if(enteredOtp.isEmpty) {
        CustomSnackBar("Please enter OTP", "E");
        return;
      }
      if(enteredOtp == receivedOtp){
        if (kDebugMode) {
          print("ForgotReceiveOtp: $receivedOtp");
        }

        CustomSnackBar("OTP Verified Successfully", "S");
        Get.toNamed(AppRoutes.newPasswordScreen);
      } else {
        CustomSnackBar("Invalid OTP. Please try again.", "E");
      }
    } catch (e) {
      CustomSnackBar("Error: ${e.toString()}", "E");
    } finally {
      isLoading.value = false;
    }
  }

  String? validateOtp(String? otp) {
    if (otp == null || otp.isEmpty) {
      return "Please enter OTP";
    }
    if (otp.length != 4) {
      return "OTP must be 4 digits";
    }
    return null;
  }

  Future<void> forgotResendOtp() async {

    try {

      isLoading.value = true;

      final Map<String, String>? initialRequest =
      storage.read(Constants.forgotInitialRequest);

      if (initialRequest == null) {
        CustomSnackBar("No data found in storage. Please try again.", "E");
        return;
      }

      String? email = initialRequest[Constants.email];

      if (email == null || email.isEmpty) {
        CustomSnackBar("Data is missing. Please provide a valid data.", "E");
        return;
      }

      Map<String, String> request = {
        Constants.email : email
      };

      var response = await apiService.forgotPassword(request);
      print("Resend:$request");
      if (response.success == true) {
        storage.write(Constants.forgotPasswordReceivedOtp, response.otp);
        timeCounter.value = 60;
        if (_timer.isActive) {
          _timer.cancel();
        }
        startTimer();
        CustomSnackBar("OTP sent successfully!", "S");
      } else {
        CustomSnackBar(response.message ?? "Failed to send an OTP.", "E");
      }
    } catch (e) {
      CustomSnackBar(e.toString(), "E");
    } finally {
      isLoading.value = false;
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeCounter.value > 0) {
        timeCounter.value--;
      } else {
        _timer.cancel();
        // storage.remove(Constants.forgotPasswordReceivedOtp);
      }
    });
  }

  @override
  void dispose() {
    // otpController.value.dispose();
    super.dispose();
  }

  void resetForm(){
    otpController.value.clear();
  }
}
