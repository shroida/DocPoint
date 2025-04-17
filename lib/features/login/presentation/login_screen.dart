import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/core/widgets/app_text_button.dart';
import 'package:docpoint/core/widgets/navigate_signup_or_login.dart';
import 'package:docpoint/features/login/presentation/logic/login_cubit.dart';
import 'package:docpoint/features/login/presentation/logic/login_state.dart';
import 'package:docpoint/features/login/presentation/widgets/forgot_password.dart';
import 'package:docpoint/features/login/presentation/widgets/user_type_selector_login.dart';
import 'package:docpoint/features/login/presentation/widgets/login_form.dart';
import 'package:docpoint/features/login/presentation/widgets/logo_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login successful!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Safe way to navigate after current build frame
                  Future.microtask(() {
                    if (!context.mounted) return;
                    context.go(Routes.homePage);
                  });
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login failed: ${state.errorMessage}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return BlocBuilder<CurrentUserCubit, CurrentUserState>(
                  builder: (context, currentUserState) {
                    final cubitLogin = context.read<LoginCubit>();

                    return Column(
                      children: [
                        const LogoLogin(),
                        SizedBox(height: 10.h),
                        const UserTypeSelectorLogin(),
                        SizedBox(height: 10.h),
                        const LoginForm(),
                        SizedBox(height: 10.h),
                        const ForgotPassword(),
                        if (state is LoginLoading)
                          const CircularProgressIndicator()
                        else
                          AppTextButton(
                            buttonText: 'Login',
                            textStyle:
                                AppStyle.heading2.copyWith(color: Colors.white),
                            onPressed: () {
                              if (cubitLogin.formKey.currentState?.validate() ??
                                  false) {
                                cubitLogin.login();
                              }
                            },
                          ),
                        SizedBox(height: 10.h),
                        const NavigateSignupOrLogin(login: true)
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
