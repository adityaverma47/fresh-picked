import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/app_export.dart';
import '../../../core/services/api_services.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/utils/flutter_toast.dart';
import '../../../data/models/LoginModel/login_model.dart';
import '../../../router/app_routes.dart';
import '../../../widgets/custom_snack_bar.dart';

class LoginController extends GetxController {

  RxBool isLoading = false.obs;
  RxBool isVisibility = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final storage = GetStorage();
  final secureStorage = const FlutterSecureStorage();
  Rx<TextEditingController>  emailController = TextEditingController().obs;
  Rx<TextEditingController>  passwordController = TextEditingController().obs;

  final ApiService apiService = ApiService(dio: DioClient().getDio());

  @override
  void onInit() {
    super.onInit();
    // emailController.value.text = storage.read(Constants.email) ?? '';
  }

  Future<void> login() async {

    if (!formKey.currentState!.validate()) {
      return;
    }

    final  email = emailController.value.text.trim().toLowerCase();
    final  password = passwordController.value.text.trim();

    isLoading.value = true;

    try {

      Map<String, String> request = {
        'email': email,
        'password': password,
      };

      LoginModel response = await apiService.login(request);
      print("Login Response1: $response");

      if (response.success == true) {
        storage.write(Constants.email, email);
        storage.write(Constants.password, password);
        await saveUserSession(response);
        print("Login Response2: ${response.success}");
        print("Login Response3: ${response.message}");
        Get.offAllNamed(AppRoutes.bottomBar);
        CustomSnackBar(response.message.toString(), "S");
      } else {
        CustomSnackBar(response.message ?? "Login failed", "E");
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() {
    isVisibility.value = !isVisibility.value;
  }

  Future<void> saveUserSession(LoginModel response) async {
    // storage.write(Constants.id, response.user?.id);
    // storage.write(Constants.name, response.user?.fullName);
    // storage.write(Constants.status, response.status);
    // storage.write(Constants.number, response.user?.number);
    // // storage.write(Constants.authKey, response.accessToken.toString());
    // await secureStorage.write(key: Constants.accessToken, value: response.accessToken.toString());
    // await secureStorage.write(key: Constants.refreshToken, value: response.refreshToken.toString());
    // print("AccessToken: ${response.accessToken.toString()}");
    // print("RefreshToken: ${response.refreshToken.toString()}");
  }

  @override
  void onClose() {
    emailController.value.clear();
    passwordController.value.clear();
    super.onClose();
  }

  void resetForm() {
    emailController.value.clear();
    passwordController.value.clear();
  }
}