import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:docpoint/features/signup/presentation/ui/widgets/patient_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:docpoint/core/widgets/app_text_form_field.dart';
import 'package:docpoint/core/widgets/app_dropdown_form_field.dart';

class DoctorForm extends StatelessWidget {
  const DoctorForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Column(
      children: [
        const PatientForm(), // Include common fields
        SizedBox(height: 10.h),
        AppDropdownFormField<String>(
          hintText: 'Select your category',
          value: cubit.category,
          items: cubit.categories.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) => cubit.setCategory(value!),
          validator: (value) {
            if (value == null) return 'Please select your category';
            return null;
          },
        ),
        SizedBox(height: 10.h),
        AppTextFormField(
          hintText: 'Experience',
          controller: cubit.experienceController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your experience';
            }
            return null;
          },
        ),
      ],
    );
  }
}
