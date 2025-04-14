import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class NavigateSignupOrLogin extends StatelessWidget {
  const NavigateSignupOrLogin({
    super.key,
    required this.login,
  });

  final bool login;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          login ? 'I already have an account' : 'Create an account',
          style: AppStyle.body1.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 3,
        ),
        GestureDetector(
          onTap: () {
            context.go(login ? Routes.signupScreen : Routes.loginScreen);
          },
          child: Text(
            login ? 'Signup' : 'Login',
            style: AppStyle.body1.copyWith(
                color: AppColors.primary, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
