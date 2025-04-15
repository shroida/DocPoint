import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:docpoint/features/home/data/datasources/get_all_doctors_datasources.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:docpoint/features/home/domain/repositories/doctors_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetAllDoctorsRepoImpl implements GetAllDoctorsRepo {
  final GetAllDoctorsDatasources _getAllDoctorsDatasources;

  GetAllDoctorsRepoImpl(this._getAllDoctorsDatasources);
  @override
  @override
  Future<Either<Failure, List<DoctorEntity>>> fetchDoctors() async {
    try {
      final doctors = await _getAllDoctorsDatasources.getAllDoctors();
      return Right(doctors.map((model) => model.toEntity()).toList());
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to fetch doctors: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> scheduleAppointment({
    required String doctorId,
    required String doctorName,
    required String patientName,
    required String category,
    required String patientId,
    required DateTime appointmentTime,
    required String status,
    String? notes,
  }) async {
    try {
      await _getAllDoctorsDatasources.scheduleAppointment(
        doctorId: doctorId,
        patientId: patientId,
        doctorName: doctorName,
        patientName: patientName,
        category: category,
        appointmentTime: appointmentTime,
        status: status,
        notes: notes,
      );
      return const Right(null); // indicate success
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
          ServerFailure('Failed to schedule appointment: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAllAppointments({
    required String id,
    required String userType,
  }) async {
    try {
      final appointments = await _getAllDoctorsDatasources.getAllAppointments(
        id: id,
        userType: userType,
      );
      return Right(appointments);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
          ServerFailure('Failed to fetch appointments: ${e.toString()}'));
    }
  }
}
