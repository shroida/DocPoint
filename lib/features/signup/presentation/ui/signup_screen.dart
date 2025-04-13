import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/core/widgets/app_text_button.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_state.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/doctor_form.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/patient_form.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/pick_image.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/user_type_selector_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  bool isPasswordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<SignupCubit, SignupState>(
              listener: (context, state) {
                if (state is SignupSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Welcome ${state.user.firstName}!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is SignupFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Signup failed. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                debugPrint('Current State: $state');

                return BlocBuilder<CurrentUserCubit, CurrentUserState>(
                  builder: (context, currentUserState) {
                    final cubitSignup = context.read<SignupCubit>();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const PickImage(),
                        SizedBox(height: 16.h),
                        const UserTypeSelectorSignup(),
                        SizedBox(height: 16.h),
                        currentUserState.userType == 'Patient'
                            ? const PatientForm()
                            : const DoctorForm(),
                        SizedBox(height: 24.h),
                        AppTextButton(
                          buttonText: "Create Account",
                          textStyle:
                              AppStyle.heading2.copyWith(color: Colors.white),
                          onPressed: () {
                            debugPrint(currentUserState.userType);

                            debugPrint(
                                'Signup button pressed'); // Debug button press
                            debugPrint(
                                'Form valid: ${cubitSignup.formKey.currentState?.validate()}');
                            if (cubitSignup.formKey.currentState?.validate() ??
                                false) {
                              debugPrint('Calling signUp() in cubitSignup');
                              cubitSignup.signUp();
                            } else {
                              debugPrint('Form validation failed');
                            }
                          },
                        ),
                        if (state is SignupLoading)
                          const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: CircularProgressIndicator(),
                          ),
                        if (state is SignupFailure)
                          Text(
                            'Error occurred during signup',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.sp,
                            ),
                          ),
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
