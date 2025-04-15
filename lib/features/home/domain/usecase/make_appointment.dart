import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/home/domain/repositories/doctors_repo.dart';
import 'package:fpdart/fpdart.dart';

class MakeAppointment implements UseCase<void, AppointmentParams> {
  final GetAllDoctorsRepo _doctorsRepo;

  MakeAppointment(this._doctorsRepo);
  @override
  Future<Either<Failure, void>> call(AppointmentParams params) async {
    return await _doctorsRepo.scheduleAppointment(
        appointmentTime: params.appointmentTime,
        doctorId: params.doctorId,
        doctorName: params.doctorName,
        patientName: params.patientName,
        category: params.category,
        patientId: params.patientId,
        status: params.status,
        notes: params.notes);
  }
}

class AppointmentParams {
  final String doctorId;
  final String doctorName;
  final String category;
  final String patientId;
  final String patientName;
  final DateTime appointmentTime;
  final String status;
  String? notes;

  AppointmentParams(
      {required this.doctorId,
      this.notes,
      required this.patientId,
      required this.patientName,
      required this.doctorName,
      required this.category,
      required this.appointmentTime,
      required this.status});
}
