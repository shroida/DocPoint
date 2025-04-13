import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/core/widgets/app_text_button.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_state.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/doctor_form.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/patient_form.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/pick_image.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/user_type_selector.dart';
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
              child: Column(
                children: [Image.asset('assets/logo.jpg')],
              )),
        ),
      ),
    );
  }
}
