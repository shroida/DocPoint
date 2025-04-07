import 'package:bloc/bloc.dart';
import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';

class CurrentuserCubit extends Cubit<CurrentUserState> {
  CurrentuserCubit() : super(CurrentUserInitial());
}
