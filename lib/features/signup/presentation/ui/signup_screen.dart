import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/core/widgets/app_snackbar.dart';
import 'package:docpoint/core/widgets/app_text_button.dart';
import 'package:docpoint/core/widgets/navigate_signup_or_login.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_state.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/doctor_form.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/patient_form.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/pick_image.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/user_type_selector_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
                  showAppSnackBar(
                    context: context,
                    message: 'Welcome ${state.user.firstName}!',
                    backgroundColor: Colors.green,
                  );

                  Future.microtask(() {
                    if (!context.mounted) return;
                    context.go(Routes.homePage); // or pushReplacement
                  });
                } else if (state is SignupFailure) {
                  showAppSnackBar(
                    context: context,
                    message: 'Signup failed. Please try again.',
                    backgroundColor: Colors.red,
                  );
                }
              },
              builder: (context, state) {
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
                            if (cubitSignup.formKey.currentState?.validate() ??
                                false) {
                              if (cubitSignup.imageFile == null) {
                                showAppSnackBar(
                                  context: context,
                                  message: 'Please pick a profile image.',
                                  backgroundColor: Colors.orange,
                                );
                              }
                              if (cubitSignup
                                  .experienceController.text.isEmpty) {
                                showAppSnackBar(
                                  context: context,
                                  message: 'Please enter your experience.',
                                  backgroundColor: Colors.red,
                                );
                              } else {
                                cubitSignup.signUp(
                                    userType:
                                        currentUserState.userType ?? 'Patient');
                              }
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
                        SizedBox(height: 10.h),
                        const NavigateSignupOrLogin(login: false)
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
