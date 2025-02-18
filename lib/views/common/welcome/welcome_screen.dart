import 'package:fresh_picked/views/common/welcome/controller/welcome_controller.dart';
import 'package:fresh_picked/widgets/custom_button_bottom.dart';
import 'package:get/get.dart';
import '../../../core/app_export.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              opacity: const AlwaysStoppedAnimation(5),
              ImageConstants.welcomeBackGroundImage),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 180.h),
                const Text(
                  "Fresh grown \nproduce, neighbour \nto neighbour",
                  style: TextStyle(
                      fontSize: 25,
                      color: ColorConstants.white,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtonBottom(
                      onTap: () {
                        controller.navigateToLogin();
                      },
                      width: 100.w,
                      height: 25.h,
                      text: "LOGIN",
                      shape: ButtonShape.RoundedBorder6,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: ColorConstants.lightPrimaryColor,
                          fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.navigateToRegister();
                      },
                      child: Text(
                        "Sign Up ",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: ColorConstants.white,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
