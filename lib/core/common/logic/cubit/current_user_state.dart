import 'package:docpoint/core/common/domain/entities/user.dart';

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
  const CurrentUserError(this.message);
}

class CurrentUserTypeUpdated extends CurrentUserState {
  const CurrentUserTypeUpdated(String userType) : super(userType: userType);
}
