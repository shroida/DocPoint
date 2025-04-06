import 'dart:io';

import 'package:docpoint/core/widgets/app_dropdown_form_field.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/patient_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  final cubit = context.read<SignupCubit>();
                  return Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile image picker
                        Center(
                          child: GestureDetector(
                            onTap: cubit.pickImage,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: cubit.imageFile != null
                                  ? Image.file(
                                      File(cubit.imageFile!.path),
                                      width: 100.w,
                                      height: 100.h,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: const Color(0xffF0EFFF),
                                      width: 100.w,
                                      height: 100.h,
                                      child: Center(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.grey.shade600,
                                          size: 30.sp,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // User type selection
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Select User Type'),
                              Wrap(
                                spacing: 8.0,
                                children: ['Patient', 'Doctor'].map((type) {
                                  final isSelected = cubit.userType == type;
                                  return ChoiceChip(
                                    label: Text(type),
                                    selected: isSelected,
                                    onSelected: (_) => cubit.setUserType(type),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        // City dropdown (common for both)
                        AppDropdownFormField<String>(
                          hintText: 'Select your city',
                          value: cubit.city,
                          items: cubit.cities.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) => cubit.setCity(value!),
                          validator: (value) {
                            if (value == null) return 'Please select your city';
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        // Show appropriate form based on user type
                        cubit.userType == 'Patient'
                            ? const PatientForm()
                            : const DoctorForm(),
                        SizedBox(height: 20.h),
                        ElevatedButton(
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              // Handle registration
                            }
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
