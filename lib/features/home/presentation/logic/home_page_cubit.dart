import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:docpoint/features/home/domain/usecase/get_all_appointments.dart';
import 'package:docpoint/features/home/domain/usecase/get_all_doctors.dart';
import 'package:docpoint/features/home/domain/usecase/make_appointment.dart';
import 'package:docpoint/features/home/domain/usecase/update_status_usecase.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final GetAllDoctors _getAllDoctors;
  final MakeAppointment _makeAppointment;
  final GetAllAppointments _getAllAppointments;
  final UpdateStatusUsecase _updateStatusUsecase;

  List<DoctorEntity>? doctorList;
  List<AppointmentEntity>? appointmentList;

  HomePageCubit(this._getAllDoctors, this._makeAppointment,
      this._getAllAppointments, this._updateStatusUsecase)
      : super(HomePageInitial());

  Future<void> getAllDoctors() async {
    emit(HomePageLoading());

    final response = await _getAllDoctors.call(NoParams());

    response.fold(
      (failure) {
        emit(HomePageError(_mapFailureToMessage(failure)));
      },
      (doctors) {
        doctorList = doctors;
        emit(HomePageLoaded(doctors: doctors));
      },
    );
  }

  Future<void> scheduleAppointment(AppointmentParams params) async {
    emit(AppointmentLoading());

    final result = await _makeAppointment.call(params);

    result.fold(
      (failure) => emit(AppointmentFailure(_mapFailureToMessage(failure))),
      (_) => emit(AppointmentSuccess()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server error: ${failure.message}';
      case NetworkFailure _:
        return 'Network error: ${failure.message}';
      default:
        return 'Unexpected error: ${failure.message}';
    }
  }

  Future<void> updateStatusAppointment(
      UpdateStatusParams updateStatusParams) async {
    emit(AppointmentLoading());
    final result = await _updateStatusUsecase.call(updateStatusParams);

    result.fold(
      (failure) => emit(AppointmentFailure(_mapFailureToMessage(failure))),
      (_) => emit(AppointmentSuccess()),
    );
  }

  Future<void> getAllAppointments(
      {required String id, required String userType}) async {
    emit(AppointmentLoading());

    final response = await _getAllAppointments.call(AllAppointmentParams(
      id: id,
      userType: userType,
    ));

    response.fold(
      (failure) => emit(AppointmentFailure(_mapFailureToMessage(failure))),
      (appointments) {
        appointmentList = appointments;
        emit(HomePageLoaded(doctors: doctorList, appointments: appointments));
      },
    );
  }
}
