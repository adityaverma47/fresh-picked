import '../../../core/app_export.dart';
import '../../../router/app_routes.dart';
import '../../../widgets/custom_button_bottom.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
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
                TextFormField(
                  obscureText: obscureText,
                  style: const TextStyle(color: ColorConstants.primaryColor),
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: ColorConstants.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: ColorConstants.primaryColor, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: ColorConstants.primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
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
                TextFormField(
                  obscureText: obscureText,
                  style: const TextStyle(color: ColorConstants.primaryColor),
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: ColorConstants.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: ColorConstants.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: ColorConstants.primaryColor, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: ColorConstants.primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtonBottom(
                      onTap: () {
                        // Navigator.pushNamed(context, AppRoutes.passwordSuccessScreen);
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
