import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/home/domain/entities/doctor_entity.dart';
import 'package:docpoint/features/home/domain/usecase/get_all_doctors.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final GetAllDoctors _getAllDoctors;
  List<DoctorEntity>? doctorList;

  HomePageCubit(this._getAllDoctors) : super(HomePageInitial());

  Future<void> getAllDoctors() async {
    emit(HomePageLoading());

    final response = await _getAllDoctors.call(NoParams());

    response.fold(
      (failure) {
        emit(HomePageError(_mapFailureToMessage(failure)));
      },
      (doctors) {
        doctorList = doctors;
        emit(HomePageLoaded(doctors));
      },
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
}
