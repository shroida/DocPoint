import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class GetAllDoctorsRepo {
  Future<Either<Failure, List<DoctorEntity>>> fetchDoctors();
  Future<void> scheduleAppointment({
    required String doctorId,
    required String patientId,
    required DateTime appointmentTime,
    required String status,
    String? notes,
  });
}
