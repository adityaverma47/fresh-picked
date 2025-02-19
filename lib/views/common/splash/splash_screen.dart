import 'package:fresh_picked/views/common/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import '../../../core/app_export.dart';
import '../../../router/app_routes.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: Center(
        child: Obx(() {
          if (controller.isSplashDone.value) {
            Future.delayed(Duration.zero, () {
              Get.offNamed(AppRoutes.welcomeScreen);
            });
          }

          return Image.asset(
            ImageConstants.logoFreshPicked,
            filterQuality: FilterQuality.high,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          );
        }),
      ),
    );
  }
}
