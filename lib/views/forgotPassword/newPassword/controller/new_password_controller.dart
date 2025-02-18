import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/app_export.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/services/dio_client.dart';
import '../../../../core/utils/flutter_toast.dart';
import '../../../../widgets/custom_snack_bar.dart';

class NewPasswordController extends GetxController {

  RxBool isLoading = false.obs;
  RxBool isNewPasswordVisibility = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  final storage = GetStorage();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService(dio: DioClient().getDio());

  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;

  Future<void> confirmChangePassword()  async {

    if(formKey.currentState!.validate()) {
      isLoading.value = true;

      final newPassword = newPasswordController.value.text.trim();
      final confirmPassword = confirmPasswordController.value.text.trim();

      try {

        // final String? email = storage.read(Constants.forgotPasswordEmailOrNumber);
        // final String? receivedOtp = storage.read(Constants.forgotPasswordReceivedOtp);
        // final String? verifiedToken = storage.read(Constants.verifiedToken);

        // if(email!.isEmpty || receivedOtp!.isEmpty || verifiedToken!.isEmpty) {
        //   throw Exception("Invalid Storage data. Please try again");
        // }
        Map<String, String> request = {
          // Constants.credentialKey : email,
          // Constants.newPassword : newPassword,
          // Constants.forgotPasswordReceivedOtp : receivedOtp,
          // Constants.verifiedToken : verifiedToken
        };

        var response = await apiService.resetPassword(request);


        if(response.success == true) {
          // CustomDialogUtils.showCustomDialog(title: "Password Update Successfully", message: "Your Password change has been successfully updated.", confirmText: "OK",
          //     onConfirm: (){
          //       print("Password change acknowledged!");
          //       Get.offAllNamed(AppRoutes.loginScreen);
          //     }, isCancellable: true);
        } else {
          CustomSnackBar(response.message ?? "Password not changed", "E");
        }

      } catch(e) {
        Message_Utils.displayToast("ResetApiError: ${e.toString()}");
      }  finally {
        isLoading.value = false;
      }

    }
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisibility.value = !isNewPasswordVisibility.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void resetForm(){
    newPasswordController.value.clear();
    confirmPasswordController.value.clear();
  }


}