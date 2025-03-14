import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/color_constants.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    this.maxLength,
    this.onChanged,
    this.shape,
    this.padding,
    this.variant,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.validator,
    this.labelText,
    this.readOnly,
    this.onTap,
    this.capital,
    this.floatingLabelBehavior,
    this.autofocus,
    this.minLines,
    this.labelAlign = TextAlign.start,
    this.inputFormatters,
  });

  bool? autofocus;
  FloatingLabelBehavior? floatingLabelBehavior;
  TextCapitalization? capital;
  Function(String)? onChanged;
  VoidCallback? onTap;
  TextFormFieldShape? shape;
  TextFormFieldPadding? padding;
  TextFormFieldVariant? variant;
  Alignment? alignment;
  double? width;
  EdgeInsetsGeometry? margin;
  TextEditingController? controller;
  FocusNode? focusNode;
  bool? isObscureText;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  int? maxLength;
  int? maxLines;
  int? minLines;
  String? hintText;
  bool? readOnly;
  Widget? prefix;
  BoxConstraints? prefixConstraints;
  Widget? suffix;
  BoxConstraints? suffixConstraints;
  FormFieldValidator<String>? validator;
  String? labelText;
  final TextAlign labelAlign;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: _buildTextFormFieldWidget(),
    )
        : _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Container(
              alignment: labelAlign == TextAlign.start ? Alignment.centerLeft : Alignment.center,
              padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
              child: Text(
                labelText!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          TextFormField(
            onTap: onTap,
            onChanged: onChanged,
            controller: controller,
            focusNode: focusNode,
            autofocus: autofocus ?? false,
            obscureText: isObscureText!,
            readOnly: readOnly ?? false,
            maxLength: maxLength,
            minLines: minLines ?? 1,
            textInputAction: textInputAction ?? TextInputAction.next,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: _buildDecoration(),
            validator: validator,
            inputFormatters: inputFormatters,
            textAlign: TextAlign.start, // Aligns the input text to start
            textCapitalization: capital ?? TextCapitalization.sentences,
          ),
        ],
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      counterText: "",
      hintText: hintText ?? "",
      floatingLabelBehavior:
      floatingLabelBehavior ?? FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorConstants.primaryColor,
          )),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: ColorConstants.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      errorStyle: TextStyle(
          color: ColorConstants.errorBorder),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: ColorConstants.errorBorder)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 2,
            color: ColorConstants.primaryColor,
          )),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.White:
        return ColorConstants.white;
      case TextFormFieldVariant.FillWhiteA700:
        return ColorConstants.white;
      case TextFormFieldVariant.OutlineGray30004_1:
        return ColorConstants.outlineStroke;
      default:
        return ColorConstants.white;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.White:
        return true;
      case TextFormFieldVariant.FillWhiteA700:
        return true;
      case TextFormFieldVariant.OutlineGray30004_1:
        return true;
      case TextFormFieldVariant.FillDeeporange5001:
        return true;
      case TextFormFieldVariant.FillGray10001:
        return true;
      case TextFormFieldVariant.OutlineGray30004_2:
        return true;
      case TextFormFieldVariant.OutlineScecondaryColor:
        return true;
      case TextFormFieldVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingT16:
        return EdgeInsets.only(
          left: 16.w,
          top: 16.h,
          bottom: 16.h,
        );
      case TextFormFieldPadding.PaddingAll19:
        return EdgeInsets.all(
          19.w,
        );
      case TextFormFieldPadding.PaddingT15:
        return EdgeInsets.only(
          left: 12.w,
          top: 15.h,
          right: 12.w,
          bottom: 15.h,
        );
      case TextFormFieldPadding.PaddingLR16TB8:
        return EdgeInsets.only(
          left: 16.w,
          top: 8.h,
          right: 16.w,
          bottom: 8.h,
        );
      case TextFormFieldPadding.PaddingAll8:
        return EdgeInsets.all(
          8.w,
        );
      case TextFormFieldPadding.PaddingAll4:
        return EdgeInsets.all(
          4.w,
        );
      case TextFormFieldPadding.PaddingAll12:
        return EdgeInsets.all(
          12.w,
        );
      case TextFormFieldPadding.PaddingAll0:
        return EdgeInsets.all(
          0.w,
        );
      default:
        return EdgeInsets.all(
          16.w,
        );
    }
  }
}

enum TextFormFieldShape {
  RoundedBorder6,
}

enum TextFormFieldPadding {
  PaddingAll16,
  PaddingT16,
  PaddingAll19,
  PaddingT15,
  PaddingAll8,
  PaddingAll4,
  PaddingAll12,
  PaddingAll0,
  PaddingLR16TB8
}

enum TextFormFieldVariant {
  None,
  OutlineGray30004,
  White,
  FillWhiteA700,
  OutlineGray30004_1,
  FillDeeporange5001,
  FillGray10001,
  OutlineGray30004_2,
  OutlineScecondaryColor,
  FillneutralN20
}
