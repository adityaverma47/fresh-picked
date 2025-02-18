import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_picked/core/app_export.dart';
import '../../core/utils/color_constants.dart';
import '../custom_image_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.height,
      this.styleType,
      this.styleTypeTwo,
      this.leadingWidth,
      this.leading,
      this.isBackBtnVisible,
      this.title,
      this.centerTitle,
      this.onTap,
      this.actions,
      this.leadIcon,
      this.bgColor});

  final double height;
  final Widget? leadIcon;
  final Style? styleType;
  final String? styleTypeTwo;
  final double? leadingWidth;
  final Color? bgColor;
  final Widget? leading;

  final bool? isBackBtnVisible;

  final Widget? title;

  final VoidCallback? onTap;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: bgColor ?? ColorConstants.white,
      flexibleSpace: _getStyle(),
      //leadingWidth: leadingWidth ?? 0,
      // leading: InkWell(
      //   onTap: onTap() ?? "",
      //   child: Padding(
      //     padding:
      //         EdgeInsets.only(left: 16.w, top: 18.h, bottom: 18.h, right: 19.w),
      //     child: CustomImageView(
      //       height: 12.h,
      //       width: 18.w,
      //       svgPath: ImageConstant.arrowBackAppbar,
      //     ),
      //   ),
      // ),

      leading: (isBackBtnVisible ?? true) == false
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: onTap,
                icon: leadIcon ??
                    CustomImageView(
                      height: 10.h,
                      width: 18.w,
                      imagePath: ImageConstants.logoFreshPicked,
                    ),
              ),
            ),
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        double.maxFinite,
        height,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgGradientPink700Pink900:
        return Container(
          height: 100.h,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                0.5,
                0,
              ),
              end: Alignment(
                0.5,
                1,
              ),
              colors: [
                ColorConstants.white,
                ColorConstants.white,
              ],
            ),
          ),
        );
      case Style.bgFillWhite:
        return Container(
          // height: 49.h,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: ColorConstants.white,
          ),
        );
      case Style.bgFillGrey:
        return Container(
          height: 49.h,
          decoration: const BoxDecoration(
            color: ColorConstants.grey,
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgGradientPink700Pink900,
  bgFillWhite,
  bgFillGrey,
}
