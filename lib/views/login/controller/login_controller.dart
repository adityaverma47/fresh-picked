import '../../../core/app_export.dart';
import '../../../data/models/LoginModel/login_model.dart';

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

      var response = await apiService.login(request);
      if (response.success == true) {
        storage.write(Constants.email, email);
        storage.write(Constants.password, password);
        await saveUserSession(response);
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
    storage.write(Constants.id, response.data!.user!.sId);
    storage.write(Constants.fullName, response.data!.user!.fullName);
    storage.write(Constants.status, response.success);
    storage.write(Constants.phone, response.data!.user!.phone);
    // storage.write(Constants.authToken, response.accessToken.toString());
    await secureStorage.write(key: Constants.accessToken, value: response.data!.accessToken.toString());
    await secureStorage.write(key: Constants.refreshToken, value: response.data!.refreshToken.toString());
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