import 'package:fresh_picked/core/app_export.dart';

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
          initialRoute: AppRoutes.initialRoute,
          getPages: AppRoutes.pages,
          title: "Fresh-Picked",
        ),
      ),
    );
  }
}

