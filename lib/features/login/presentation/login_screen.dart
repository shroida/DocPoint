import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/core/widgets/app_text_button.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/user_type_selector_signup.dart';
import 'package:docpoint/features/login/presentation/widgets/login_form.dart';
import 'package:docpoint/features/login/presentation/widgets/logo_login.dart';
import 'package:flutter/material.dart';
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
              child: Column(
                children: [
                  const LogoLogin(),
                  SizedBox(height: 10.h),
                  const UserTypeSelector(),
                  SizedBox(height: 10.h),
                  const LoginForm(),
                  SizedBox(height: 10.h),
                  AppTextButton(
                    buttonText: 'Login',
                    textStyle: AppStyle.heading2.copyWith(color: Colors.white),
                    onPressed: () {

                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
