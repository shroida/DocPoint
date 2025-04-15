import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:docpoint/features/home/domain/repositories/doctors_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetAllDoctors implements UseCase<List<DoctorEntity>, NoParams> {
  final GetAllDoctorsRepo _doctorsRepo;

  GetAllDoctors(this._doctorsRepo);
  @override
  Future<Either<Failure, List<DoctorEntity>>> call(NoParams params) async {
    return await _doctorsRepo.fetchDoctors();
  }
}
