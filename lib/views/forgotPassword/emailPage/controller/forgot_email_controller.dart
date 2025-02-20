import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/app_export.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/dio_client.dart';
import '../../../../core/utils/flutter_toast.dart';
import '../../../../router/app_routes.dart';
import '../../../../widgets/custom_snack_bar.dart';

class ForgotEmailController extends GetxController {

  RxBool isLoading = false.obs;
  final storage = GetStorage();
  final secureStorage = const FlutterSecureStorage();
  Rx<TextEditingController> emailController = TextEditingController().obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService(dio: DioClient().getDio());

  Future<void> sendOTP() async {

    if(!formKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;

    final email = emailController.value.text.trim();

    try {
      String? token = await secureStorage.read( key: Constants.accessToken);

      if (token == null || token.isEmpty) {
        throw Exception("Token not found. Please log in again.");
      }

      Map<String, String> initialRequest = {
        Constants.email: email,
      };

      var response = await apiService.forgotPassword(initialRequest);
      storage.write(Constants.forgotInitialRequest, initialRequest);

      if(response.success == true) {
        // print("ForgotPasswordResponseToken: ${response.verifyToken}");
        String? receivedOtp = response.otp?.toString() ?? "" ;
        // String? verifiedToken = response.verifyToken?.toString() ?? "";
        storage.write(Constants.forgotPasswordReceivedOtp, receivedOtp);
        storage.write(Constants.forgotPasswordEmail, email);
        Get.toNamed(AppRoutes.forgotVerifyOtpScreen);
        CustomSnackBar(response.message.toString(), "S");
      } else{
        CustomSnackBar(response.message ?? "ForgotPassword failed", "E");
      }
    }
    catch(e) {
      Message_Utils.displayToast("ForgotApiError: ${e.toString()}");
    }
    finally {
      isLoading.value = false;
    }
  }

  void resetForm(){
    emailController.value.clear();
  }

}