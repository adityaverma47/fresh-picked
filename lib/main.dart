import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/router/app_routes.dart';
import 'package:fresh_picked/widgets/dismiss_keyboard.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: DismissKeyboard(
        child: GetMaterialApp(
          theme: ThemeData(
              textSelectionTheme:  const TextSelectionThemeData(
                  cursorColor: ColorConstants.primaryColor,
                  selectionHandleColor: ColorConstants.primaryColor,
                  selectionColor: ColorConstants.primaryColor)),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.bottomBar,
          getPages: AppRoutes.pages,
          title: "Cng-Care",
        ),
      ),
    );
  }
}

