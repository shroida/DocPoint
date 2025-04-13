import 'package:docpoint/core/common/domain/entites/user.dart';

// current_user_state.dart
abstract class CurrentUserState {
  final String? userType;

  const CurrentUserState({this.userType});
}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserLoading extends CurrentUserState {}

class CurrentUserAuthenticated extends CurrentUserState {
  final User user;
  CurrentUserAuthenticated(this.user);
}

class CurrentUserUnauthenticated extends CurrentUserState {}

class CurrentUserError extends CurrentUserState {
  final String message;
  CurrentUserError(this.message);
}

class CurrentUserTypeUpdated extends CurrentUserState {
  final String? userType;
  CurrentUserTypeUpdated(this.userType);
}
