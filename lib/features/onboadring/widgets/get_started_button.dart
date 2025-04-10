import 'package:docpoint/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30.h,
      left: 24.w,
      right: 24.w,
      child: ElevatedButton(
        onPressed: () {
          context.go(Routes.signupScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2A7DBC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          minimumSize: Size(double.infinity, 56.h),
        ),
        child: Text(
          "Get Started",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
