import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInit());
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
  void setUserType(String type) {
    userType = type;
  }

  void setCity(String selectedCity) {
    city = selectedCity;
  }

  void setCategory(String selectedCategory) {
    category = selectedCategory;
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
