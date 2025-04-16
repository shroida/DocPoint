import 'package:docpoint/core/widgets/app_text_form_field.dart';
import 'package:docpoint/features/login/presentation/logic/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return Form(
        key: loginCubit.formKey,
        child: Column(
          children: [
            AppTextFormField(
              controller:loginCubit. emailController,
              hintText: 'Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            AppTextFormField(
              hintText: 'Password',
              controller:loginCubit. passwordController,
              isObscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ],
        ));
  }
}
