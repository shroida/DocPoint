import 'package:docpoint/features/signup/domain/entities/user_sign_up.dart';

class UserSignUpModel extends UserSignUp {
  UserSignUpModel({
    required super.email,
    required super.password,
    required super.firstName,
    required String super.lastName,
    required String super.phoneNumber,
    required String super.city,
  });

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) {
    return UserSignUpModel(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      city: json['city'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'city': city,
      };
}
