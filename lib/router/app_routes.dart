import 'package:get/get.dart';
import '../views/common/splash/binding/splash_binding.dart';
import '../views/common/splash/splash_screen.dart';
import '../views/login/binding/login_binding.dart';
import '../views/login/login_screen.dart';

class AppRoutes {
  static String initialRoute = '/initial_route';
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String verifyOtpScreen = '/otp_screen';
  static const String newPasswordScreen = '/new_password_screen';
  static const String dashBoardScreen = '/dashboard_screen';
  static const String bottomBar = '/bottom_navigation_bar_screen';


  static List<GetPage> pages = [
    GetPage(
        name: initialRoute,
        page: () => const SplashScreen(), // Splash Screen
        bindings: [SplashBinding()]),
    GetPage(
        name: loginScreen,
        page: () => const LoginScreen(), // Login Screen
        bindings: [LoginBinding()]),
    // GetPage(
    //     name: forgotPasswordVerifyOtpScreen,
    //     page: () => const ForgotPasswordVerifyOtpScreen(),
    //     bindings: [ForgotPasswordVerifyOtpBinding()]),
    // GetPage(
    //     name: forgotPasswordScreen,
    //     page: () => const ForgotPasswordScreen(), // Forgot Password Screen
    //     bindings: [ForgotPasswordBinding()]),
    // GetPage(
    //     name: newPasswordScreen,
    //     page: () => const NewPasswordScreen(), // New Password Screen
    //     bindings: [NewPasswordBinding()]),
    // GetPage(
    //     name: registrationScreen,
    //     page: () => const RegistrationScreen(), // Registration Screen
    //     bindings: [RegistrationBinding()]),

  ];
}
