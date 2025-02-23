import '../../../../core/app_export.dart';

class SplashController extends GetxController {

  final storage = GetStorage();
  static const secureStorage = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      _navigateAfterSplash();
    });
  }

  void _navigateAfterSplash() async {
    print("Splash");
    final status = storage.read(Constants.status) ?? false;
    final accessToken = await secureStorage.read(key: Constants.accessToken);
    if (accessToken == null || accessToken.isEmpty) {
      Get.offAllNamed(AppRoutes.loginScreen);
    } else {
      if (status == true) {
        Get.offAllNamed(AppRoutes.bottomBar);
      } else {
        Get.offAllNamed(AppRoutes.loginScreen);
      }
    }
  }
}
