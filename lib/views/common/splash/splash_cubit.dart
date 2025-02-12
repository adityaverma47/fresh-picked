import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_picked/views/common/splash/splash_state.dart';
import '../../../core/app_export.dart';


class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    load();
  }

  Future<void> load() async {
    await Future.delayed(const Duration(milliseconds: Constants.splashShowTime));
    emit(SplashNavigateToWelcome()); // Emit navigation state
  }
}


