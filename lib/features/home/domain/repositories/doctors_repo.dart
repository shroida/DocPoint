import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DoctorsRepo {
  Future<Either<Failure, List<DoctorEntity>>> fetchDoctors();
}
