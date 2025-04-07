part of 'signup_cubit.dart';

class SignupState {}

class SignupInit extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final User user;

  SignupSuccess(this.user);
}

class SignupFailure extends SignupState {}

class ImageUpdated extends SignupState {
  final XFile? imageFile;
  ImageUpdated(this.imageFile);
}

class SignupUserTypeUpdated extends SignupState {
  final String? userType;
  SignupUserTypeUpdated(this.userType);
}
