import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:docpoint/features/home/data/datasources/get_all_doctors_datasources.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:docpoint/features/home/domain/repositories/doctors_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetAllDoctorsRepoImpl implements GetAllDoctorsRepo {
  final GetAllDoctorsDatasources _getAllDoctorsDatasources;

  GetAllDoctorsRepoImpl(this._getAllDoctorsDatasources);
  @override
  Future<Either<Failure, List<DoctorEntity>>> fetchDoctors() async {
    try {
      final doctors = await _getAllDoctorsDatasources.getAllDoctors();
      if (doctors.isEmpty) {
        return Left(ServerFailure('No doctors found'));
      }
      return Right(doctors.map((model) => model.toEntity()).toList());
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to fetch doctors: ${e.toString()}'));
    }
  }
}
