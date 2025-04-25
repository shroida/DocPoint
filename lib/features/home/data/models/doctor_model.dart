import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  DoctorModel(
      {required super.email,
      required super.firstName,
      required super.category,
      required super.experience,
      required super.imageUrl,
      required super.userType,
      required super.id,
      required super.lastName,
      required super.phoneNumber,
      required super.city});
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      userType: "Doctor",
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      city: json['city'] as String,
      imageUrl: json['avatar_url'] as String?,
      experience: json['experience'] as int,
      category: json['category'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'city': city,
      'avatar_url': imageUrl,
      'experience': experience,
      'category': category,
    };
  }

  DoctorEntity toEntity() {
    return DoctorEntity(
      userType: "Doctor",
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      city: city,
      imageUrl: imageUrl,
      experience: experience,
      category: category,
    );
  }
}
