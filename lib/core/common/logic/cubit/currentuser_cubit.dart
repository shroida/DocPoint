import 'package:bloc/bloc.dart';
import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/common/domain/usecase/current_user_usecase.dart';
import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/usecase/usecase.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  final CurrentUserUsecase _currentUserUsecase;
  CurrentUserCubit(this._currentUserUsecase) : super(CurrentUserInitial());
  String userType = 'Patient';
  void setUserType(String type) {
    userType = type;
    emit(CurrentUserTypeUpdated(userType)); // Make sure you have this state
  }

  void updateUser(User user) {
    userType = user.userType ?? 'Patient';
    emit(CurrentUserAuthenticated(user));
  }

  late User currentUser;
  Future<void> checkAuthStatus() async {
    emit(CurrentUserLoading());
    final res = await _currentUserUsecase.call(NoParams());

    res.fold(
      (failure) => emit(CurrentUserUnauthenticated()),
      (user) {
        currentUser = user;
        emit(CurrentUserAuthenticated(user));
      },
    );
  }
}
