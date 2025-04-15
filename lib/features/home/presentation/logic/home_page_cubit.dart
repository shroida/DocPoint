import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:docpoint/features/home/domain/usecase/get_all_doctors.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final GetAllDoctors _getAllDoctors;
  List<DoctorEntity>? doctorList;

  HomePageCubit(this._getAllDoctors) : super(HomePageInitial());

  Future<void> getAllDoctors() async {
    debugPrint('[Cubit] getAllDoctors called');
    emit(HomePageLoading());

    final response = await _getAllDoctors.call(NoParams());

    response.fold(
      (failure) {
        debugPrint('[Cubit] Error: ${failure.message}');
        emit(HomePageError(_mapFailureToMessage(failure)));
      },
      (doctors) {
        debugPrint('[Cubit] Loaded ${doctors.length} doctors');
        doctorList = doctors;
        emit(HomePageLoaded(doctors));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error: ${failure.message}';
      case NetworkFailure:
        return 'Network error: ${failure.message}';
      default:
        return 'Unexpected error: ${failure.message}';
    }
  }
}
