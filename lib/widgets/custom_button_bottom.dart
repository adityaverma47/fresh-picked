import '../core/app_export.dart';

class CustomButtonBottom extends StatelessWidget {
  CustomButtonBottom({super.key,
    this.loading,
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.text,
    this.prefixWidget,
    this.suffixWidget,
    this.rowWidget,
    this.child
  });

  bool? loading;

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;

  String? text;

  Widget? prefixWidget;

  Widget? suffixWidget;

  Widget? rowWidget;

  Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment!,
      child: _buildButtonWidget(),
    )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: (loading ?? false) ? () {} : onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefixWidget != null) prefixWidget!,
          if (loading ?? false)
            SizedBox(
              height: 20.h,
              width: 20.h,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: ColorConstants.white,
              ),
            )
          else
            Flexible(
              child: Text(
                text ?? "",
                textAlign: TextAlign.center,
                style: _setFontStyle(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (suffixWidget != null) suffixWidget!,
        ],
      );
    } else {
      return Center(
        child: loading ?? false
            ? SizedBox(
          height: 22.w,
          width: 22.w,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: ColorConstants.white,
          ),
        )
            : Text(
          text ?? "",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: ColorConstants.white),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        width ?? double.maxFinite,
        height ?? 40.h,
      ),
      padding: _setPadding(),
      backgroundColor: _setColor(),
      // side: _setTextButtonBorder(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll10:
        return EdgeInsets.all(
          10.h,
        );
      case ButtonPadding.PaddingT7:
        return EdgeInsets.only(
          right: 7.w,
          bottom: 7.h,
        );
      default:
        return EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.red:
        return ColorConstants.white;
      case ButtonVariant.OutlneColorHeading:
        return ColorConstants.grey;
      case ButtonVariant.FillActive:
        return ColorConstants.primaryColor;
      case ButtonVariant.FillUnctive:
        return ColorConstants.primaryColor;
      default:
        return ColorConstants.primaryColor;
    }
  }

  _setTextButtonBorder() {
    switch (variant) {
      case ButtonVariant.White:
        return BorderSide(
          color: ColorConstants.primaryColor,
          width: 1.00.w,
        );
      case ButtonVariant.OutlinePink700:
        return BorderSide(
          color: ColorConstants.white,
          width: 1.00.w,
        );
      case ButtonVariant.OutlneColorHeading:
        return BorderSide(
          // color: ColorConstants.colorHeading,
          width: 1.00.w,
        );
      case ButtonVariant.FillGray80001:
      case ButtonVariant.FillWhiteA700:
      case ButtonVariant.FillGray400:
      case ButtonVariant.FillActive:
      case ButtonVariant.FillUnctive:
        return null;
      default:
        return BorderSide(
          color: ColorConstants.white,
          width: 1.00.w,
        );
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.RoundedBorder16:
        return BorderRadius.circular(
          16.00.w,
        );
      case ButtonShape.RoundedBorder3:
        return BorderRadius.circular(
          3.00.w,
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          6.00.w,
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.MontserratRegular13:
        return TextStyle(
          color: ColorConstants.white,
          fontSize: 13.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          height: 1.23.h,
        );
      case ButtonFontStyle.MontserratMedium14:
        return TextStyle(
          color: ColorConstants.white,
          fontSize: 14.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          height: 1.29.h,
        );
      case ButtonFontStyle.MontserratSemiBold12:
        return TextStyle(
          color: ColorConstants.white,
          fontSize: 12.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          height: 1.25.h,
        );
      case ButtonFontStyle.MontserratSemiBold10:
        return TextStyle(
          color: ColorConstants.white,
          fontSize: 10.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          height: 1.20.h,
        );
      case ButtonFontStyle.MontserratRegular10:
        return TextStyle(
          color: ColorConstants.white,
          fontSize: 10.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          height: 1.30.h,
        );
      case ButtonFontStyle.MontserratSemiBold12WhiteA700:
        return TextStyle(
          color: ColorConstants.white,
          fontSize: 12.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          height: 1.25.h,
        );
      default:
        return TextStyle(
          color: ColorConstants.white,
          fontSize: 12.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          height: 1.25.h,
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder6,
  RoundedBorder16,
  RoundedBorder3,
}

enum ButtonPadding {
  PaddingT12,
  PaddingAll10,
  PaddingT7,
}

enum ButtonVariant {
  red,
  White,
  FillGray80001,
  OutlinePink700,
  FillWhiteA700,
  OutlineGray30001_1,
  FillGray400,
  FillActive,
  FillUnctive,
  OutlneColorHeading
}

enum ButtonFontStyle {
  MontserratRegular12,
  MontserratRegular13,
  MontserratMedium14,
  MontserratSemiBold12,
  MontserratSemiBold10,
  MontserratRegular10,
  MontserratSemiBold12WhiteA700,
}
