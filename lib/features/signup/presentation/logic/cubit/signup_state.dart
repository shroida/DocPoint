part of 'signup_cubit.dart';

class SignupState {}

class SignupInit extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {}

class ImageUpdated extends SignupState {
  final XFile? imageFile;
  ImageUpdated(this.imageFile);
}
