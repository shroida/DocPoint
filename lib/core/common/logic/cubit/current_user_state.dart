import 'package:docpoint/core/common/domain/entites/user.dart';

abstract class CurrentUserState {}

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
