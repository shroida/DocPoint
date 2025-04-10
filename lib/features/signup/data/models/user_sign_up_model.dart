import 'package:docpoint/features/signup/domain/entities/user_sign_up.dart';

class UserSignUpModel extends UserSignUp {
  UserSignUpModel({
    required super.email,
    required super.password,
    required super.firstName,
    required String super.lastName,
    required String super.phoneNumber,
    required String super.city,
    super.imageUrl,
    super.category,
    super.experience,
  });

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) {
    return UserSignUpModel(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      city: json['city'] as String? ?? '',
      imageUrl: json['avatar_url'] as String? ?? '',
      category: json['category'] as String? ?? '',
      experience: json['experience'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'city': city,
        'avatar_url': imageUrl,
        'experience': experience,
        'category': category,
      };
}
