import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/router/app_routes.dart';
import 'package:fresh_picked/widgets/custom_button_bottom.dart';
import 'package:get/get.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.white,
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.primaryColor,
                  ),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 120.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(ImageConstants.freshPickedText),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Login to your account",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: ColorConstants.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            controller: controller.emailController.value,
                            onChanged: (val) {
                              final lowercaseValue = val.toLowerCase();
                              if (controller.emailController.value.text !=
                                  lowercaseValue) {
                                controller.emailController.value.text =
                                    lowercaseValue;
                                controller.emailController.value.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(offset: lowercaseValue.length),
                                );
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email is required";
                              }

                              final lowercaseValue = value.toLowerCase();

                              if (!GetUtils.isEmail(lowercaseValue)) {
                                return "Enter a valid email address";
                              }
                              final regex =
                                  RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
                              if (!regex.hasMatch(lowercaseValue)) {
                                return "Email must be a valid Gmail address";
                              }

                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            labelText: "Email",
                            hintText: "Enter your email",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          SizedBox(height: 18.h),
                          Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            controller: controller.passwordController.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              }
                              final passwordRegex = RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{6,}$',
                              );
                              if (!passwordRegex.hasMatch(value)) {
                                return "Password must have at least 6 characters, 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character";
                              }

                              return null;
                            },
                            onChanged: (val) {},
                            suffix: IconButton(
                              onPressed: controller.togglePasswordVisibility,
                              icon: controller.isVisibility.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              iconSize: 25,
                            ),
                            textInputAction: TextInputAction.next,
                            isObscureText: !controller.isVisibility.value,
                            hintText: "Enter your password",
                            textInputType: TextInputType.text,
                            labelText: "Password",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          SizedBox(height: 10.h),
                          InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, AppRoutes.forgotEmailScreen);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: ColorConstants.primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButtonBottom(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.registerScreen);
                                },
                                width: 140.w,
                                height: 45.h,
                                text: "LOGIN",
                                shape: ButtonShape.RoundedBorder6,
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.lightPrimaryColor),
                              ),
                              SizedBox(width: 5.w),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.registerScreen);
                                },
                                child: const Text(
                                  "Create now",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstants.primaryColor),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}
