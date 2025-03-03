import '../../../core/app_export.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisibility = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  final storage = GetStorage();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService(dio: DioClient().getDio());

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> numberController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final name = nameController.value.text.trim();
    final phone = numberController.value.text.trim();
    final email = emailController.value.text.trim().toLowerCase();
    final password = passwordController.value.text.trim();
    final confirmPassword = confirmPasswordController.value.text.trim();

    isLoading.value = true;

    if (password != confirmPassword) {
      CustomSnackBar("Passwords do not match", "E");
      isLoading.value = false;
      return;
    }
    try {
      Map<String, String> request = {
        Constants.email: email,
        Constants.fullName :name,
        Constants.phone : phone,
        Constants.password : password
      };

      var response = await apiService.register(request);
      if (response.success == true) {
        storage.write(Constants.status, response.success);
        Get.toNamed(AppRoutes.bottomBar);
        CustomSnackBar(response.message.toString(), "S");
      } else {
        CustomSnackBar(response.message ?? "Registration failed", "E");
      }
    } catch (e) {
      Message_Utils.displayToast("Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisibility.value = !isPasswordVisibility.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    numberController.value.dispose();
    passwordController.value.dispose();
    confirmPasswordController.value.dispose();
    super.onClose();
  }

  void resetForm() {
    nameController.value.clear();
    emailController.value.clear();
    numberController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();
  }
}
