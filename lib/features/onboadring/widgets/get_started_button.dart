import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/constants/constants.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30.h,
      left: 24.w,
      right: 24.w,
      child: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              Future.delayed(const Duration(seconds: 3), () {
                if (context.mounted) {
                  isLoggedInUser
                      ? context.go(Routes.homePage)
                      : context.go(Routes.loginScreen);
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A7DBC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              minimumSize: Size(double.infinity, 56.h),
              elevation: 0,
            ),
            child: state is CurrentUserLoading
                ? SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
