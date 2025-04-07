import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/features/signup/domain/usecase/user_sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final UserSignUpUsecase _signUpRepoUsecase;
  SignupCubit(this._signUpRepoUsecase) : super(SignupInit());
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
  String userType = 'Patient';
  String city = 'Giza';
  String category = 'Dentist';

  // Image file
  XFile? imageFile;
  Future<void> signUp() async {
    try {
      final response = await _signUpRepoUsecase.call(UserSignUpParams(
          email: emailController.text,
          password: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneController.text,
          city: city));
      response.fold(
        (failure) {
          debugPrint('Signup failed: ${failure.toString()}');
          emit(SignupFailure());
        },
        (user) {
          debugPrint('Signup success for user: ${user.email}');
          emit(SignupSuccess(user));
        },
      );
    } catch (e, stackTrace) {
      debugPrint('Signup error: $e');
      debugPrint('Stack trace: $stackTrace');
      emit(SignupFailure());
    }
  }

  void setCity(String selectedCity) {
    city = selectedCity;
  }

  void setCategory(String selectedCategory) {
    category = selectedCategory;
  }

  void setUserType(String type) {
    userType = type;
    emit(SignupUserTypeUpdated(userType)); // Make sure you have this state
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile = pickedFile;
      }
      emit(ImageUpdated(imageFile));
    } catch (e) {
      throw e.toString();
    }
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
