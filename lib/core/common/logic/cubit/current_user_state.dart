import 'package:docpoint/core/common/domain/entites/user.dart';

class CurrentUserState {}

final class CurrentUserInitial extends CurrentUserState {}

final class CurrentUserLoggedIn extends CurrentUserState {
  final User user;
  CurrentUserLoggedIn(this.user);
}
