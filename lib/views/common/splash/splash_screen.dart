import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_picked/core/utils/image_constants.dart';
import 'package:fresh_picked/router/app_routes.dart';
import 'package:fresh_picked/views/common/splash/splash_cubit.dart';
import 'package:fresh_picked/views/common/splash/splash_state.dart';
import '../../../core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToWelcome) {
            Navigator.pushReplacementNamed(context, AppRoutes.welcomeScreen);
          }
        },
        child: Scaffold(
          backgroundColor: ColorConstants.white,
          body: Image.asset(
            ImageConstants.logoFreshPicked,
            filterQuality: FilterQuality.high,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
