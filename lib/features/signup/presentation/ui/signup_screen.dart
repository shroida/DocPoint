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
            child: BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
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
                  ],
                );
              },
            ),
          ),
        )));
  }
}
