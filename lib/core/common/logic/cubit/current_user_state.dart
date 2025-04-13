import 'package:docpoint/core/common/domain/entites/user.dart';

abstract class CurrentUserState {
  final String? userType;

  const CurrentUserState({this.userType});
}

class CurrentUserInitial extends CurrentUserState {
  const CurrentUserInitial() : super(userType: 'Patient');
}

class CurrentUserLoading extends CurrentUserState {
  const CurrentUserLoading({super.userType});
}

class CurrentUserAuthenticated extends CurrentUserState {
  final User user;

  CurrentUserAuthenticated(this.user) : super(userType: user.userType);
}

class CurrentUserUnauthenticated extends CurrentUserState {
  const CurrentUserUnauthenticated({super.userType});
}

class CurrentUserError extends CurrentUserState {
  final String message;

  CurrentUserError(this.message) : super();
}

class CurrentUserTypeUpdated extends CurrentUserState {
  final String userType;

  CurrentUserTypeUpdated(this.userType) : super(userType: userType);
}
