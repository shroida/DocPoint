import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/home/domain/repositories/doctors_repo.dart';
import 'package:fpdart/fpdart.dart';

class UpdateStatusUsecase implements UseCase<void, UpdateStatusParams> {
  late final GetAllDoctorsRepo _getAllDoctorsRepo;
  @override
  Future<Either<Failure, void>> call(UpdateStatusParams params) async {
    return await _getAllDoctorsRepo.updateStatusAppointment(
        appointmentId: params.appointmentId, status: params.status);
  }
}

class UpdateStatusParams {
  final String appointmentId;
  final String status;

  UpdateStatusParams({required this.appointmentId, required this.status});
}
