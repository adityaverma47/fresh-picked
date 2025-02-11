import 'package:flutter/material.dart';
import 'package:fresh_picked/views/common/splash/splash_screen.dart';
import '../views/common/welcome/welcome_screen.dart';
import '../views/login/login_screen.dart';

class AppRoutes {

  static const String initialRoute = '/';
  static const String welcomeScreen = '/welcome_screen';
  static const String login = '/login';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      // case welcomeScreen:
      //   return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
