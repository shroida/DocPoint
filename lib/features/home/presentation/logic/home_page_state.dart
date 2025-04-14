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
