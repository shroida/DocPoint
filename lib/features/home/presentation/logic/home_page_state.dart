import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';

abstract class HomePageState {}

final class HomePageInitial extends HomePageState {}

final class HomePageLoading extends HomePageState {}

final class HomePageLoaded extends HomePageState {
  final List<DoctorEntity> doctors;

  HomePageLoaded(this.doctors);
}

final class HomePageError extends HomePageState {
  final String message;

  HomePageError(this.message);
}

// Appointment States
final class AppointmentLoading extends HomePageState {}

final class AppointmentSuccess extends HomePageState {
  final List<AppointmentEntity>? appointments;

  AppointmentSuccess({this.appointments});
}

final class AppointmentFailure extends HomePageState {
  final String message;

  AppointmentFailure(this.message);
}
