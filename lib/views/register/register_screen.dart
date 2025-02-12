import '../../core/app_export.dart';
import '../../router/app_routes.dart';
import '../../widgets/custom_button_bottom.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                    "Create your new account",
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
                  style: TextStyle(fontSize: 16.sp, color: ColorConstants.primaryColor,fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  style: const TextStyle(color: ColorConstants.primaryColor),
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: const TextStyle(color: ColorConstants.primaryColor,fontSize: 14,fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.primaryColor, width: 2), // Optional: Make it slightly thicker when focused
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                Text(
                  " Create Password",
                  style: TextStyle(fontSize: 16.sp, color: ColorConstants.primaryColor,fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  obscureText: true,
                  style: const TextStyle(color: ColorConstants.primaryColor),
                  decoration: InputDecoration(
                    hintText: "Create your password",
                    hintStyle: const TextStyle(color: ColorConstants.primaryColor,fontSize: 14,fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.primaryColor, width: 2), // Optional: Make it slightly thicker when focused
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                Text(
                  " Confirm Password",
                  style: TextStyle(fontSize: 16.sp, color: ColorConstants.primaryColor,fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  obscureText: true,
                  style: const TextStyle(color: ColorConstants.primaryColor),
                  decoration: InputDecoration(
                    hintText: "Confirm your  password",
                    hintStyle: const TextStyle(color: ColorConstants.primaryColor,fontSize: 14,fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.primaryColor, width: 2), // Optional: Make it slightly thicker when focused
                    ),
                  ),
                ),
                SizedBox(height: 25.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtonBottom(
                      onTap: (){
                        // Navigator.pushNamed(context, AppRoutes.forgotEmailScreen);
                      },
                      width: 140.w,
                      height: 45.h,
                      text: "SIGNUP",
                      shape: ButtonShape.RoundedBorder6,
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text("Already have an account?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: ColorConstants.lightPrimaryColor),),
                    SizedBox(width: 5.w),
                    GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, AppRoutes.loginScreen);
                        },
                        child: const Text("Login now",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: ColorConstants.primaryColor),))
                  ],)

              ],
            ),
          ),
        ),
      ),
    );
  }
}