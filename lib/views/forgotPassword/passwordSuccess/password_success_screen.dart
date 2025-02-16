import '../../../core/app_export.dart';
import '../../../router/app_routes.dart';
import '../../../widgets/custom_button_bottom.dart';

class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

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
                  "Reset Password?",
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: ColorConstants.primaryColor,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Your new password ",
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
                TextFormField(
                  style: const TextStyle(color: ColorConstants.primaryColor),
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: const TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      const BorderSide(color: ColorConstants.primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      const BorderSide(color: ColorConstants.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: ColorConstants.primaryColor,
                          width:
                          2), // Optional: Make it slightly thicker when focused
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtonBottom(
                      onTap: (){
                        Navigator.pushNamed(context, AppRoutes.verifyOtpScreen);
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
}
