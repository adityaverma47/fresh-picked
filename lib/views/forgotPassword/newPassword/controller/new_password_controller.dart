import '../../../../core/app_export.dart';

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

      try {

        final String? userId = storage.read(Constants.id);
        final String? newPassword = storage.read(Constants.newPassword);


        // if(userId!.isEmpty || newPassword!.isEmpty) {
        //   throw Exception("Invalid Storage data. Please try again");
        // }
        // Map<String, String> request = {
        //  Constants.userId : userId,
        //  Constants.newPassword : newPassword
        // };
        //
        // var response = await apiService.resetPassword(request);
        //
        //
        // if(response.success == true) {
        //   CustomDialogUtils.showCustomDialog(title: "Password Update Successfully", message: "Your Password change has been successfully updated.", confirmText: "OK",
        //       onConfirm: (){
        //         Get.offAllNamed(AppRoutes.loginScreen);
        //       }, isCancellable: true);
        // } else {
        //   CustomSnackBar(response.message ?? "Password not changed", "E");
        // }

      } catch(e) {
        Message_Utils.displayToast("ResetApiError: ${e.toString()}");
      }
      finally {
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