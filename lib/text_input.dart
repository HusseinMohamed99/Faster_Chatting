import 'package:numchat/Core/color_manager.dart';
import 'package:numchat/Core/style_manager.dart';
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
  final void Function(String)? onChanged;
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
    final BorderRadius effectiveRadius = borderRadius ??
        const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        );

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      style: inputTextStyle ?? StyleManager.font15,
      obscureText: isObscureText ?? false,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder: focusedBorder ?? _buildBorder(ColorManager.lightGrayColor, effectiveRadius),
        enabledBorder: enabledBorder ?? _buildBorder(ColorManager.lightGrayColor, effectiveRadius),
        errorBorder: _buildBorder(Colors.red, effectiveRadius),
        focusedErrorBorder: _buildBorder(Colors.red, effectiveRadius),
        prefixIconConstraints: hasConstraints
            ? BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.2,
                maxHeight: 60,
              )
            : null,
        prefixIcon: prefixIcon,
        hintStyle: hintStyle ?? StyleManager.font13LighterGrayRegular,
        hintText: hintText,
        fillColor: backgroundColor ?? ColorManager.whiteColor,
        filled: true,
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  InputBorder _buildBorder(Color color, BorderRadius radius) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1),
      borderRadius: radius,
    );
  }
}

