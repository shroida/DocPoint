import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoLogin extends StatelessWidget {
  const LogoLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: CircleAvatar(radius: 60.h, child: Image.asset('assets/logo.jpg')),
    );
  }
}
