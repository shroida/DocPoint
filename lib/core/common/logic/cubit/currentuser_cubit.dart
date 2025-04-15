import 'package:bloc/bloc.dart';
import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/common/domain/usecase/current_user_usecase.dart';
import 'package:docpoint/core/common/domain/usecase/logout_usecase.dart';
import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/usecase/usecase.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  final CurrentUserUsecase _currentUserUsecase;
  final LogoutUsecase _logoutUsecase;
  CurrentUserCubit(this._currentUserUsecase, this._logoutUsecase)
      : super(const CurrentUserInitial());
  String userType = '';
  void setUserType(String type) {
    userType = type;
    emit(CurrentUserTypeUpdated(userType)); // Make sure you have this state
  }

  Future<void> updateUser(User user) async {
    emit(const CurrentUserLoading());
    try {
      currentUser = user;

      if (user.userType?.toLowerCase() == 'doctor') {
        userType = 'Doctor';
      } else {
        userType = 'Patient';
      }

      emit(CurrentUserAuthenticated(user));
      emit(CurrentUserTypeUpdated(userType));
    } catch (e) {
      emit(CurrentUserError(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    await _currentUserUsecase.call(NoParams());
  }

  User? currentUser; // Change from late to nullable
  Future<void> checkAuthStatus() async {
    emit(const CurrentUserLoading());
    final res = await _currentUserUsecase.call(NoParams());
    res.fold(
      (failure) {
        userType = '';
        emit(const CurrentUserUnauthenticated());
      },
      (user) {
        currentUser = user;
        userType =
            user.userType?.toLowerCase() == 'doctor' ? 'Doctor' : 'Patient';
        emit(CurrentUserAuthenticated(user));
      },
    );
  }

  Future<void> logout() async {
    try {
      emit(const CurrentUserLoading());
      await _logoutUsecase.call();
      currentUser = null;

      emit(const CurrentUserUnauthenticated());
    } catch (e) {
      emit(CurrentUserError(e.toString()));
    }
  }
}
