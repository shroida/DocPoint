import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFF0064FA),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFF9E9E9E),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintStyle: hintStyle ??
            const TextStyle(
              fontSize: 14,
              color: Color(0xFF9E9E9E),
              fontWeight: FontWeight.normal,
            ),
        hintText: hintText,
        fillColor: backgroundColor ?? const Color(0xFFF5F5F5),
        filled: true,
      ),
      items: items,
      onChanged: onChanged,
      style: inputTextStyle ??
          const TextStyle(
            fontSize: 14,
            color: Color(0xFF0D1F3C),
            fontWeight: FontWeight.w500,
          ),
      validator: validator != null ? (value) => validator!(value) : null,
      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF0D1F3C)),
      dropdownColor: backgroundColor ?? const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(16.0),
      isExpanded: true,
    );
  }
}
