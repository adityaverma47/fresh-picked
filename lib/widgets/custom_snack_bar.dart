import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/utils/color_constants.dart';

void CustomSnackBar(String msg, String type) {
  Get.rawSnackbar(
    messageText: Text(msg,style: const TextStyle(), ),
    icon: type == "S"
        ? const Icon(
      Icons.check_circle_rounded,
      color: ColorConstants.success,
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
    backgroundColor: ColorConstants.bgGrey,
    duration: const Duration(milliseconds: 2000),
    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
    snackPosition: SnackPosition.TOP,
    borderRadius: 5,
    animationDuration: const Duration(milliseconds: 1000),
    backgroundGradient: const LinearGradient(
      colors: [ColorConstants.bgGrey, ColorConstants.bgGrey],
    ),
  );
}
