import 'package:docpoint/core/widgets/app_dropdown_form_field.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:docpoint/core/widgets/app_text_form_field.dart';

class PatientForm extends StatefulWidget {
  const PatientForm({super.key});

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  @override
  Widget build(BuildContext context) {
    final signupCubit = context.read<SignupCubit>();
    return Column(
      children: [
        AppTextFormField(
          hintText: 'Email',
          controller: signupCubit.emailController,
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
          controller: signupCubit.passwordController,
          isObscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        AppTextFormField(
          hintText: 'First name',
          controller: signupCubit.firstNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your first name';
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        AppTextFormField(
          hintText: 'Last name',
          controller: signupCubit.lastNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your last name';
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        AppTextFormField(
          hintText: 'Phone number',
          controller: signupCubit.phoneController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
        SizedBox(height: 10.h),
        AppDropdownFormField<String>(
          hintText: 'Select your city',
          value: signupCubit.city,
          items: signupCubit.cities.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              signupCubit.city = value!;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Please select your city';
            }
            return null;
          },
        ),
      ],
    );
  }
}
