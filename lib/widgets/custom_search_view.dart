
// ignore: must_be_immutable
import '../core/app_export.dart';

class CustomSearchView extends StatelessWidget {
  CustomSearchView(
      {this.shape,
      this.onPressed,
      this.onChanged,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.hintText,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.readOnly,
      this.hintStyle,
      this.keyboardType,
      this.capital,
      this.context});

  BuildContext? context;

  SearchViewShape? shape;

  VoidCallback? onPressed;

  Function(String)? onChanged;

  SearchViewPadding? padding;

  SearchViewVariant? variant;

  SearchViewFontStyle? fontStyle;
  SearchViewHintTextStyle? hintStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;
  TextCapitalization? capital;
  Widget? suffix;
  TextInputType? keyboardType;
  BoxConstraints? suffixConstraints;
  bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildSearchViewWidget(context),
          )
        : _buildSearchViewWidget(context);
  }

  _buildSearchViewWidget(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: TextFormField(
        onTap: onPressed,
        onChanged: onChanged,
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly ?? false,
        decoration: _buildDecoration(context),
        keyboardType: keyboardType,
        textCapitalization: capital ?? TextCapitalization.sentences,
      ),
    );
  }

  _buildDecoration(BuildContext context) {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setHintStyle(context),
      border: _setBorderStyle(context),
      enabledBorder: _setBorderStyle(context),
      focusedBorder: _setBorderStyle(context),
      disabledBorder: _setBorderStyle(context),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(context),
      filled: _setFilled(context),
      isDense: true,
      contentPadding: _setPadding(context),
    );
  }

  // _setFontStyle(BuildContext context) {
  //   switch (fontStyle) {
  //     case SearchViewFontStyle.robotoNormalN60w12:
  //       return TextStyle(
  //         color: ColorConstants.neutral60,
  //         fontSize: 20.sp ,
  //         fontFamily: 'RobotoRegular',
  //         fontWeight: FontWeight.w400,
  //       );
  //     case SearchViewFontStyle.RobotoReg12neu60w400:
  //       return TextStyle(
  //         color: ColorConstants.neutral60,
  //         fontSize: 12.sp ,
  //         fontFamily: 'RobotoRegular',
  //         fontWeight: FontWeight.w400,
  //       );
  //     case SearchViewFontStyle.RobotoMed12pri300w500:
  //       return TextStyle(
  //         color: ColorConstants.primary300,
  //         fontSize: 12.sp,
  //         fontFamily: 'RobotoMedium',
  //         fontWeight: FontWeight.w500,
  //       );
  //     case SearchViewFontStyle.RobotoReg12neu900w400:
  //       return TextStyle(
  //         color: ColorConstants.neutral900,
  //         fontSize: 12.sp ,
  //         // fontSize: 12.sp * MediaQuery.textScaleFactorOf(context),
  //         fontFamily: 'RobotoRegular',
  //         fontWeight: FontWeight.w400,
  //       );
  //     default:
  //       return TextStyle(
  //         color: ColorConstants.textOne,
  //         fontSize: 13.sp,
  //         fontFamily: 'Montserrat',
  //         fontWeight: FontWeight.w400,
  //       );
  //   }
  // }

  _setHintStyle(BuildContext context) {
    switch (hintStyle) {
      case SearchViewHintTextStyle.RobotoReg12neu60w400:
        return TextStyle(
          color: ColorConstants.lightPrimaryColor,
          fontSize: 12.sp,
          fontFamily: 'RobotoRegular',
          fontWeight: FontWeight.w400,
        );
      default:
        return TextStyle(
          color: ColorConstants.textOne,
          fontSize: 13.sp ,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        );
    }
  }

  _setOutlineBorderRadius(BuildContext context) {
    switch (shape) {
      case SearchViewShape.RoundedBorder5:
        return BorderRadius.circular(
          30.00.r,
        );
      default:
        return BorderRadius.circular(
          48.00.r,
        );
    }
  }

  _setBorderStyle(BuildContext context) {
    switch (variant) {
      case SearchViewVariant.fillOutlineStock:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(context),
          borderSide: const BorderSide(color: ColorConstants.lightPrimaryColor),
        );
      case SearchViewVariant.fillWhiteBorderCta:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(context),
          borderSide: const BorderSide(color: ColorConstants.primaryColor),
        );
      case SearchViewVariant.BorderOutneStroke:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(context),
          borderSide: const BorderSide(color: ColorConstants.primaryColor),
        );
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(context),
          borderSide: const BorderSide(color: ColorConstants.primaryColor),
        );
    }
  }

  _setFillColor(BuildContext context) {
    switch (variant) {
      case SearchViewVariant.BorderOutneStroke:
        return ColorConstants.white;
      case SearchViewVariant.fillWhiteBorderCta:
        return ColorConstants.white;
      case SearchViewVariant.fillOutlineStock:
        return ColorConstants.white;
      default:
        return ColorConstants.white;
    }
  }

  _setFilled(BuildContext context) {
    switch (variant) {
      case SearchViewVariant.FillGray10001:
        return true;
      case SearchViewVariant.fillOutlineStock:
        return true;
      case SearchViewVariant.BorderOutneStroke:
        return true;
      case SearchViewVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding(BuildContext context) {
    switch (padding) {
      case SearchViewPadding.PaddingTB16:
        return EdgeInsets.only(
          top: 16.h,
          bottom: 16.h,
        );
      case SearchViewPadding.PaddingAll8:
        return EdgeInsets.only(
          left: 8.w,
          right: 8.w,
          top: 8.h,
          bottom: 8.h,
        );

      default:
        return EdgeInsets.only(
          left: 16.w,
          top: 12.h,
          bottom: 12.h,
        );
    }
  }
}

enum SearchViewShape {
  RoundedBorder5,
}

enum SearchViewPadding {
  PaddingTB16,
  PaddingAll8,
}

enum SearchViewVariant {
  fillOutlineStock,
  None,
  FillGray10001,
  BorderOutneStroke,
  fillWhiteBorderCta
}

enum SearchViewHintTextStyle { RobotoReg12neu60w400 }

enum SearchViewFontStyle {
  MontserratRegular13,
  RobotoReg12neu60w400,
  RobotoMed12pri300w500,
  RobotoReg12neu900w400,
  robotoNormalN60w12,
  robotoMed12neu5w400
}
