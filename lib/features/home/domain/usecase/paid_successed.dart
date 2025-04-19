import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/home/domain/repositories/doctors_repo.dart';
import 'package:fpdart/fpdart.dart';

class PaidSuccessed implements UseCase<void, String> {
  final GetAllDoctorsRepo _doctorsRepo;

  PaidSuccessed(this._doctorsRepo);

  @override
  Future<Either<Failure, void>> call(String appointmentId) async {
    return await _doctorsRepo.paidSuccessed(appointmentId: appointmentId);
  }
}
