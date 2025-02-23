import '../../../core/app_export.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("splash");

    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: GetBuilder<SplashController>(// 👈 Manually initializing controller
        builder: (controller) {
          return Center(
            child: Image.asset(
              ImageConstants.logoFreshPicked,
              filterQuality: FilterQuality.high,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
