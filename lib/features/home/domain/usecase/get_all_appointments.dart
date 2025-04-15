import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/domain/repositories/doctors_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetAllAppointments
    implements UseCase<List<AppointmentEntity>, AllAppointmentParams> {
  final GetAllDoctorsRepo _doctorsRepo;

  GetAllAppointments(this._doctorsRepo);

  @override
  Future<Either<Failure, List<AppointmentEntity>>> call(
      AllAppointmentParams params) async {
    return await _doctorsRepo.getAllAppointments(
      id: params.id,
      userType: params.userType,
    );
  }
}

class AllAppointmentParams {
  final String id;
  final String userType;

  const AllAppointmentParams({
    required this.id,
    required this.userType,
  });
}
