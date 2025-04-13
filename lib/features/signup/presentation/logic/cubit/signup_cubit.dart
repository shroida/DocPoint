import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/features/signup/domain/usecase/user_sign_up_usecase.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SignupCubit extends Cubit<SignupState> {
  final UserSignUpUsecase _signUpRepoUsecase;
  final SupabaseClient supabase;
  final CurrentUserCubit currentUserCubit;

  SignupCubit(this._signUpRepoUsecase, this.supabase, this.currentUserCubit)
      : super(SignupInit());
  final formKey = GlobalKey<FormState>();

  // Common controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  // Doctor specific controllers
  final experienceController = TextEditingController();

  // Dropdown values
  String city = 'Giza';
  String category = 'Dentist';

  // Image file
  File? imageFile;

  Future<void> signUp() async {
    emit(SignupLoading());
    try {
      String? imageUrl;

      // Upload image if exists
      if (imageFile != null) {
        imageUrl = await _uploadProfileImage();
      }

      final response = await _signUpRepoUsecase.call(UserSignUpParams(
        email: emailController.text,
        imageUrl: imageUrl!,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        city: city,
        category: category,
        experience: int.tryParse(experienceController.text) ?? 0,
        userType: currentUserCubit.userType,
      ));

      response.fold(
        (failure) => emit(SignupFailure()),
        (user) => emit(SignupSuccess(user)),
      );
    } catch (e, stackTrace) {
      debugPrint('Signup error: $e\n$stackTrace');
      emit(SignupFailure());
    }
  }

  Future<String> _uploadProfileImage() async {
    try {
      final filePath = imageFile!.path;
      final fileExtension = filePath.split('.').last;
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      // Upload the file directly using the path
      await supabase.storage.from('profile-images').upload(
            fileName,
            imageFile!, // Pass the File object directly
            fileOptions: FileOptions(
              contentType: 'image/$fileExtension',
              upsert: true,
            ),
          );

      // Get public URL
      return supabase.storage.from('profile-images').getPublicUrl(fileName);
    } catch (e) {
      debugPrint('Image upload error: $e');
      throw Exception('Failed to upload profile image');
    }
  }

  void setCity(String selectedCity) {
    city = selectedCity;
  }

  void setCategory(String selectedCategory) {
    category = selectedCategory;
  }

  void setUserType(String type) {
    currentUserCubit.userType = type;
    emit(SignupUserTypeUpdated(
        currentUserCubit.userType)); // Make sure you have this state
  }

  // Lists
  final List<String> cities = [
    'Giza',
    'Cairo',
    'Alexandria',
    'Hurghada',
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
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    experienceController.dispose();
    return super.close();
  }
}
