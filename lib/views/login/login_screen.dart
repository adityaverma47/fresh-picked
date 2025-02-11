import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/widgets/custom_button_bottom.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: ColorConstants.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 120.h),
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

                /// Email Field
                Text(
                  "Email",
                  style: TextStyle(fontSize: 16.sp, color: ColorConstants.primaryColor,fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 8.h),
                TextField(
                  style: TextStyle(color: ColorConstants.white),
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    // hintStyle: TextStyle(color: ColorConstants.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ColorConstants.primaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 18.h),

                /// Password Field
                Text(
                  "Password",
                  style: TextStyle(fontSize: 16.sp, color: ColorConstants.primaryColor,fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 8.h),
                TextField(
                  obscureText: true,
                  style: TextStyle(color: ColorConstants.white),
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    // hintStyle: TextStyle(color: ColorConstants.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ColorConstants.white),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtonBottom(
                      width: 140.w,
                      height: 45.h,
                      text: "Login",
                      shape: ButtonShape.RoundedBorder6,
                    ),
                  ],
                ),
                SizedBox(height: 15.h),


                /// Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorConstants.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
