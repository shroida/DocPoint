import 'package:docpoint/features/signup/domain/entities/user_sign_up.dart';

class UserSignUpModel extends UserSignUp {
  UserSignUpModel(
      {required super.email,
      required super.password,
      required super.firstName,
      required super.lastName,
      required super.phoneNumber,
      required super.city});

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) {
    return UserSignUpModel(
        email: json['email'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        city: json['city']);
  }
}
