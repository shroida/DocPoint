import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/core/widgets/app_text_button.dart';
import 'package:docpoint/features/login/presentation/logic/login_cubit.dart';
import 'package:docpoint/features/login/presentation/widgets/user_type_selector_signup.dart';
import 'package:docpoint/features/login/presentation/widgets/login_form.dart';
import 'package:docpoint/features/login/presentation/widgets/logo_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isPasswordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<CurrentUserCubit, CurrentUserState>(
                builder: (context, state) {
                  final cubitLogin = context.read<LoginCubit>();
                  return Column(
                    children: [
                      const LogoLogin(),
                      SizedBox(height: 10.h),
                      const UserTypeSelectorLogin(),
                      SizedBox(height: 10.h),
                      const LoginForm(),
                      SizedBox(height: 10.h),
                      AppTextButton(
                        buttonText: 'Login',
                        textStyle:
                            AppStyle.heading2.copyWith(color: Colors.white),
                        onPressed: () {
                          debugPrint(
                              'Signup button pressed'); // Debug button press
                          debugPrint(
                              'Form valid: ${cubitLogin.formKey.currentState?.validate()}');
                          if (cubitLogin.formKey.currentState?.validate() ??
                              false) {
                            debugPrint('Calling signUp() in cubitLogin');
                            cubitLogin.login();
                          } else {
                            debugPrint('Form validation failed');
                          }
                        },
                      )
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
