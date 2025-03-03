import '../../../core/app_export.dart';
import 'controller/new_password_controller.dart';

class NewPasswordScreen extends GetView<NewPasswordController> {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.primaryColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 120.h),
                    child: Form(
                      key: controller.formKey,
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
                          SizedBox(height: 30.h),
                          Text(
                            "Reset Password?",
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Your new password must be different from the previous used password",
                            style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontSize: 14.sp,
                                color: ColorConstants.lightPrimaryColor,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "Create Password",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            controller: controller.newPasswordController.value,
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
                            suffix: IconButton(
                              onPressed: controller.toggleNewPasswordVisibility,
                              icon: controller.isNewPasswordVisibility.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              iconSize: 25,
                            ),
                            isObscureText:
                                !controller.isNewPasswordVisibility.value,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            labelText: "New Password",
                            hintText: "Enter your new password",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          SizedBox(height: 18.h),
                          Text(
                            "Confirm Password",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            controller:
                                controller.confirmPasswordController.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter confirm password is required";
                              }
                              if (value !=
                                  controller.newPasswordController.value.text
                                      .trim()) {
                                return "Password do not match";
                              }
                              return null;
                            },
                            suffix: IconButton(
                              onPressed:
                                  controller.toggleConfirmPasswordVisibility,
                              icon: controller.isConfirmPasswordVisible.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              iconSize: 25,
                            ),
                            isObscureText:
                                !controller.isConfirmPasswordVisible.value,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            labelText: "Confirm Password",
                            hintText: "Enter your confirm password",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          SizedBox(height: 25.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(AppRoutes.bottomBar);
                                  // controller.confirmChangePassword();
                                },
                                child: CustomButtonBottom(
                                  width: 140.w,
                                  height: 45.h,
                                  text: "CONTINUE",
                                  shape: ButtonShape.RoundedBorder6,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
