import 'package:faster_chatting/Core/color_manager.dart';
import 'package:faster_chatting/Core/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool? isObscureText;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final bool hasConstraints;
  final String? Function(String?)? onSaved;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final BorderRadius? borderRadius;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.hintText,
    this.isObscureText,
    this.prefixIcon,
    this.backgroundColor,
    this.keyboardType,
    this.inputFormatters,
    this.hasConstraints = true,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.validator,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.lightGrayColor,
                width: 1,
              ),
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.lightGrayColor,
                width: 1,
              ),
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
        prefixIconConstraints: hasConstraints
            ? BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.2,
                maxHeight: 60)
            : null,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        hintStyle: hintStyle ?? StyleManager.font13LighterGrayRegular,
        hintText: hintText,
        prefixIcon: prefixIcon,
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 12.sp,
        ),
        fillColor: backgroundColor ?? ColorManager.whiteColor,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: StyleManager.font15,
    );
  }
}
