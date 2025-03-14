import '../../core/app_export.dart';
import 'controlller/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTap: () {
          FocusScope.of(context).unfocus();
          Get.back();
        },
        height: 50,
        isBackBtnVisible: true,
        bgColor: ColorConstants.white,
      ),
      backgroundColor: ColorConstants.white,
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                color: ColorConstants.primaryColor,
              ))
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child:  Text(
                            "FreshPicked",
                            style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w800,
                                color: ColorConstants.primaryColor,
                                fontFamily: AppFonts.abhayaLibre),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                "Create your Account",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primaryColor,
                                  fontFamily: AppFonts.inter
                                ),
                              ),
                              SizedBox(height: 20.h),
                              CustomTextFormField(
                                controller: controller.nameController.value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Name is required";
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.text,
                                labelText: "Name",
                                hintText: "Enter your name",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              SizedBox(height: 8.h),
                              CustomTextFormField(
                                controller: controller.numberController.value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Phone Number is required";
                                  }
                                  final regex = RegExp(
                                      r'^(?:\+1\s?)?[2-9][1-9][0-9]\d{7}$');
                                  if (!regex.hasMatch(value)) {
                                    return "Enter a valid phone number";
                                  }
                                  return null;
                                },
                                maxLength: 10,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.phone,
                                labelText: "Phone Number",
                                hintText: "Enter your phone number",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                      TextPosition(
                                          offset: lowercaseValue.length),
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                    return "Password must have at least 6 characters, 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character";
                                  }
                                  return null;
                                },
                                suffix: IconButton(
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                  icon: controller.isPasswordVisibility.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  iconSize: 25,
                                ),
                                isObscureText:
                                    !controller.isPasswordVisibility.value,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.text,
                                labelText: "Password",
                                hintText: "Enter your password",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                      controller.passwordController.value.text
                                          .trim()) {
                                    return "Password do not match";
                                  }
                                  return null;
                                },
                                suffix: IconButton(
                                  onPressed: controller
                                      .toggleConfirmPasswordVisibility,
                                  icon:
                                      controller.isConfirmPasswordVisible.value
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              SizedBox(height: 8.h),
                              Obx(
                                () => CustomButtonBottom(
                                  onTap: controller.isLoading.value
                                      ? null
                                      : () => controller.registerUser(),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 55.h, vertical: 15.h),
                                  text: "Sign In",
                                  height: 45.h,
                                  loading: controller.isLoading.value,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: ColorConstants.lightPrimaryColor),
                            ),
                            SizedBox(width: 8.w),
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.toNamed(AppRoutes.loginScreen);
                              },
                              child: const Text(
                                "Login Now",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primaryColor),
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
    );
  }
}
