import 'package:docpoint/features/login/domain/entities/user_login.dart';

class UserLoginModel extends UserLogin {
  UserLoginModel(
      {required super.email,
      required super.password,
      required super.firstName,
      required super.lastName,
      required super.phoneNumber,
      required super.city});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
        email: json['email'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        city: json['city']);
  }
}
