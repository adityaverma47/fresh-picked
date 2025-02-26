import 'package:fresh_picked/chat/binding/chat_binding.dart';
import 'package:fresh_picked/chat/chat_screen.dart';
import 'package:fresh_picked/views/AddProduct/add_product_screen.dart';
import 'package:fresh_picked/views/common/welcome/binding/welcome_binding.dart';
import 'package:fresh_picked/views/common/welcome/welcome_screen.dart';
import 'package:fresh_picked/views/dashboard/binding/dashboard_binding.dart';
import 'package:fresh_picked/views/dashboard/dashboard_screen.dart';
import 'package:fresh_picked/views/profile/binding/profile_binding.dart';
import 'package:fresh_picked/views/profile/profile_screen.dart';
import 'package:get/get.dart';
import '../views/addProduct/binding/add_product_binding.dart';
import '../views/bottom_bar/binding/bottom_binding.dart';
import '../views/bottom_bar/bottom_screen.dart';
import '../views/common/splash/binding/splash_binding.dart';
import '../views/common/splash/splash_screen.dart';
import '../views/favourites/binding/favourites_binding.dart';
import '../views/favourites/favourites_screen.dart';
import '../views/forgotPassword/emailPage/binding/forgot_email_binding.dart';
import '../views/forgotPassword/emailPage/forgot_email_screen.dart';
import '../views/forgotPassword/newPassword/binding/new_password_binding.dart';
import '../views/forgotPassword/newPassword/new_password_screen.dart';
import '../views/forgotPassword/verifyOtp/binding/verify_otp_binding.dart';
import '../views/forgotPassword/verifyOtp/verify_otp_screen.dart';
import '../views/login/binding/login_binding.dart';
import '../views/login/login_screen.dart';
import '../views/register/binding/register_binding.dart';
import '../views/register/register_screen.dart';

class AppRoutes {
  static String initialRoute = '/initial_route';
  static const String welcomeScreen = '/welcome_screen';
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String forgotEmailPageScreen = '/forgot_email_page_screen';
  static const String forgotVerifyOtpScreen = '/forgot_verify_otp_screen';
  static const String newPasswordScreen = '/new_password_screen';
  static const String dashBoardScreen = '/dashboard_screen';
  static const String bottomBar = '/bottom_navigation_bar_screen';
  static const String favouritesScreen = '/favourites_screen';
  static const String addProductScreen = '/add_product_screen';
  static const String chatScreen = '/chat_screen';
  static const String profileScreen = '/profile_screen';


  static List<GetPage> pages = [
    GetPage(
        name: initialRoute,
        page: () => const SplashScreen(), // Splash Screen
        bindings: [SplashBinding()]),
    GetPage(
        name: welcomeScreen,
        page: () => const WelcomeScreen(), // Splash Screen
        bindings: [WelcomeBinding()]),
    GetPage(
        name: loginScreen,
        page: () => const LoginScreen(), // Login Screen
        bindings: [LoginBinding()]),
    GetPage(
        name: forgotVerifyOtpScreen,
        page: () => const ForgotVerifyOtpScreen(),
        bindings: [ForgotVerifyOtpBinding()]),
    GetPage(
        name: forgotEmailPageScreen,
        page: () => const ForgotEmailPageScreen(), // Forgot Password Screen
        bindings: [ForgotEmailBinding()]),
    GetPage(
        name: newPasswordScreen,
        page: () => const NewPasswordScreen(), // New Password Screen
        bindings: [NewPasswordBinding()]),
    GetPage(
        name: registerScreen,
        page: () => const RegisterScreen(), // Registration Screen
        bindings: [RegisterBinding()]),
    GetPage(
        name: dashBoardScreen,
        page: () => const DashboardScreen(), // Dashboard Screen
        bindings: [DashboardBinding()]),
    GetPage(
        name: bottomBar,
        page: () => const BottomScreen(), // Bottom Navigation Bar Screen
        bindings: [BottomBinding()]),
    GetPage(
        name: favouritesScreen,
        page: () => const FavouritesScreen(), // Favourites Screen
        bindings: [FavouritesBinding()]),
    GetPage(
        name: addProductScreen,
        page: () => const AddProductScreen(), // Add Product Screen
        bindings: [AddProductBinding()]),
    GetPage(
        name: chatScreen,
        page: () => const ChatScreen(), // Chat Screen
        bindings: [ChatBinding()]),
    GetPage(
        name: profileScreen,
        page: () => const ProfileScreen(), // Profile Screen
        bindings: [ProfileBinding()]),

  ];
}
