import 'package:docpoint/core/common/domain/entities/user.dart';
import 'package:docpoint/core/common/domain/repository/current_user_repo.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserUsecase implements UseCase<User, NoParams> {
  final CurrentUserRepo _currentUserRepo;

  CurrentUserUsecase(this._currentUserRepo);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return _currentUserRepo.currentUser();
  }
}
