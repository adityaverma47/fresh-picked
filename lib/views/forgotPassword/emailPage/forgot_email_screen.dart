import 'package:fresh_picked/router/app_routes.dart';
import 'package:get/get.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_button_bottom.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'controller/forgot_email_controller.dart';

class ForgotEmailPageScreen extends GetView<ForgotEmailController> {
  const ForgotEmailPageScreen({super.key});

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
            scrollDirection: Axis.vertical,
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
                            "Forgot Password?",
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Enter your email address and we'll send you confirmation code to reset your password",
                            style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontSize: 16.sp,
                                color: ColorConstants.lightPrimaryColor,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextFormField(
                            controller: controller.emailController.value,
                            onChanged: (val) {},
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.text,
                            labelText: "Email",
                            hintText: "Enter your email",
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          SizedBox(height: 25.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await controller.sendOTP();
                                  controller.resetForm();
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
