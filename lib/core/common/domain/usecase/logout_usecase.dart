import 'package:docpoint/core/common/domain/repository/current_user_repo.dart';

class LogoutUsecase {
  final CurrentUserRepo _currentUserRepo;

  LogoutUsecase(this._currentUserRepo);
  Future<void> call() async {
    await _currentUserRepo.logout();
  }
}
