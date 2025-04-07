import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/doctor_form.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/patient_form.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/pick_image.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/user_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  String city = 'Giza';
  String category = 'Dentist';

  bool isPasswordObscureText = true;
  final List<String> cities = [
    'Giza',
    'Cairo',
    'Alexandria',
    'hurghada',
    'Suez'
  ];
  final List<String> categories = [
    'Dentist',
    'Cardiologist',
    'General Physician',
    'Pediatrician',
    'Orthopedist',
    'Internist',
    'Surgeon',
    'ENT Specialist',
    'Dermatologist'
  ];

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
                // Handle state changes here
                if (state is SignupSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Welcome ${state.user.firstName}!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  // Navigate to home screen
                  // context.go(Routes.homeScreen);
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
                debugPrint('Current State: $state'); // Debug state changes
                final cubitSignup = context.read<SignupCubit>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const PickImage(),
                    const UserTypeSelector(),
                    SizedBox(height: 16.h),
                    cubitSignup.userType == 'Patient'
                        ? const PatientForm()
                        : const DoctorForm(),
                    SizedBox(height: 24.h),
                    _buildSignupButton(cubitSignup, state),
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton(SignupCubit cubit, SignupState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state is SignupLoading
            ? null
            : () {
                debugPrint('Signup button pressed'); // Debug button press
                debugPrint(
                    'Form valid: ${cubit.formKey.currentState?.validate()}');
                if (cubit.formKey.currentState?.validate() ?? false) {
                  debugPrint('Calling signUp() in cubit');
                  cubit.signUp();
                } else {
                  debugPrint('Form validation failed');
                }
              },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
