import 'package:docpoint/core/common/domain/entites/user.dart';

class CurrentUserState {}

final class CurrentUserInitial extends CurrentUserState {}

final class CurrentUserLoading extends CurrentUserState {}

final class CurrentUserUnauthenticated extends CurrentUserState {}

final class CurrentUserAuthenticated extends CurrentUserState {
  final User user;
  CurrentUserAuthenticated(this.user);
}
