import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:flutter/material.dart';

class AppDropdownFormField<T> extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final Color? backgroundColor;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;
  final Function(T?)? validator;

  const AppDropdownFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.backgroundColor,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: AppStyle.inputDecoration(
        hintText: hintText,
        contentPadding: contentPadding,
      ).copyWith(
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        hintStyle: hintStyle,
        fillColor: backgroundColor,
      ),
      items: items,
      onChanged: onChanged,
      style: inputTextStyle ?? AppStyle.body2,
      validator: validator != null ? (value) => validator!(value) : null,
      icon: const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary),
      dropdownColor: backgroundColor ?? AppColors.background,
      borderRadius: BorderRadius.circular(16.0),
      isExpanded: true,
    );
  }
}
