import 'package:docpoint/core/common/domain/entites/user.dart';

class CurrentUserModel {
  final String id;
  final String email;
  final String userType;
  final String firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? city;
  final String? avatarUrl;
  final String? category;
  final int? experience;

  CurrentUserModel({
    required this.id,
    required this.email,
    required this.userType,
    required this.firstName,
    this.lastName,
    this.phoneNumber,
    this.city,
    this.avatarUrl,
    this.category,
    this.experience,
  });

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      userType: json['user_type'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      city: json['city'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      category: json['category'] as String?,
      experience: json['experience'] as int?,
    );
  }

  User toUserEntity() {
    return User(
      id: id,
      password: '',
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      city: city,
      imageUrl: avatarUrl,
      category: category,
      experience: experience,
      userType: userType,
    );
  }
}
