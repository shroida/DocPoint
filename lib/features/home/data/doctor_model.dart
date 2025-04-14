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
}
