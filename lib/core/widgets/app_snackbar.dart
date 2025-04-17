import 'package:flutter/material.dart';

void showAppSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = Colors.black,
  Duration duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration,
    ),
  );
}
