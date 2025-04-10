import 'package:docpoint/core/styles/app_styles.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: AppStyle.inputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding,
      ).copyWith(
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        hintStyle: hintStyle,
        fillColor: backgroundColor,
      ),
      obscureText: isObscureText ?? false,
      style: inputTextStyle ?? AppStyle.body2,
      validator: (value) => validator(value),
    );
  }
}
