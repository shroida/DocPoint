import 'package:docpoint/core/common/domain/entites/user.dart';

class CurrentUserModel extends User {
  CurrentUserModel(
      {required super.email,
      required super.password,
      required super.firstName,
      required super.lastName,
      required super.phoneNumber,
      required super.city,
      super.experience,
      super.category,
      required super.imageUrl});

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
        email: json['email'],
        imageUrl: json['avatar_url'],
        experience: json['experience'],
        category: json['category'],
        password: json['password'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phoneNumber: json['phone_number'],
        city: json['city']);
  }
}
