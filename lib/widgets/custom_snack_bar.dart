import 'package:get/get.dart';
import '../core/app_export.dart';

void CustomSnackBar(String msg, String type) {
  Get.rawSnackbar(
    messageText: Text(msg,style: const TextStyle(color: ColorConstants.white),),
    icon: type == "S"
        ? const Icon(
      Icons.check_circle_rounded,
      color: ColorConstants.white,
    )
        : type == "E"
        ? const Icon(
      Icons.error_outline_rounded,
      color: ColorConstants.error,
    )
        : const Icon(
      Icons.warning_amber_rounded,
      color: ColorConstants.orangeOne,
    ),
    backgroundColor: ColorConstants.primaryColor,
    duration: const Duration(milliseconds: 2000),
    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 5,
    animationDuration: const Duration(milliseconds: 1000),
  );
}
