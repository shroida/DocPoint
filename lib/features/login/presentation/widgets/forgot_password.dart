import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            context.pushReplacement(Routes.forgotPasswordScreen);
          },
          child: Text(
            'Forgot Password?',
            style: AppStyle.body1.copyWith(
                color: AppColors.primary, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
