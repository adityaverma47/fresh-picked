import '../../../core/app_export.dart';
import 'package:pinput/pinput.dart';
import '../../../router/app_routes.dart';
import '../../../widgets/custom_button_bottom.dart';

class ForgotVerifyOtpScreen extends StatelessWidget {
  const ForgotVerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 120.h),
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
                  "Email Verification",
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: ColorConstants.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Enter the verification code we send you on:",
                  style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 16.sp,
                      color: ColorConstants.lightPrimaryColor,
                      fontWeight: FontWeight.w300),
                ),

                Text(
                  "your entered ",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorConstants.lightPrimaryColor,
                      fontWeight: FontWeight.w300),
                ),

                SizedBox(height: 15.h),
                Container(child: pinPut()),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't receive code?",style: TextStyle(fontSize: 14,color: ColorConstants.lightPrimaryColor,fontWeight: FontWeight.w400),),
                    SizedBox(width: 8.w,),
                    const Text("Resend OTP",style: TextStyle(fontSize: 14,color: ColorConstants.primaryColor,fontWeight: FontWeight.w600,decoration: TextDecoration.underline),),
                  ],
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImageConstants.timerIcon),
                    SizedBox(width: 5.w,),
                    const Text("Clock Timer ",style: TextStyle(fontSize: 14,color: ColorConstants.primaryColor,fontWeight: FontWeight.w600,),),
                  ],
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtonBottom(
                      onTap: (){
                        Navigator.pushNamed(context, AppRoutes.newPasswordScreen);
                      },
                      width: 140.w,
                      height: 45.h,
                      text: "CONTINUE",
                      shape: ButtonShape.RoundedBorder6,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Pinput pinPut() {
    final defaultPinTheme = PinTheme(
      width: 55,
      height: 55,
      margin: EdgeInsets.only(top: 18.h),
      textStyle: const TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: ColorConstants.primaryColor),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Pinput(
      // controller: controller.otpController.value,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // validator: controller.validateOtp,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      closeKeyboardWhenCompleted: true,
      keyboardType: TextInputType.number,
      // onCompleted: (otp) => controller.forgotPasswordVerifyOtp(),
    );
  }

}


