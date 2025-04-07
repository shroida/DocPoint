import 'package:bloc/bloc.dart';
import 'package:docpoint/core/common/domain/usecase/current_user_usecase.dart';
import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/usecase/usecase.dart';

class CurrentuserCubit extends Cubit<CurrentUserState> {
  final CurrentUserUsecase _currentUserUsecase;
  CurrentuserCubit(this._currentUserUsecase) : super(CurrentUserInitial());

  Future<void> isUserLoggedIn() async {
    final res = await _currentUserUsecase.call(NoParams());
    res.fold((failure) => emit(CurrentUserInitial()),
        (user) => emit(CurrentUserLoggedIn(user)));
  }
}
