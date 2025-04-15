import 'package:docpoint/core/common/domain/entites/user.dart';

class DoctorEntity extends User {
  DoctorEntity(
      {required super.email,
      super.password,
      required super.firstName,
      required super.category,
      required super.experience,
      required super.imageUrl,
      required super.userType,
      required super.id,
      required super.lastName,
      required super.phoneNumber,
      required super.city});
}
