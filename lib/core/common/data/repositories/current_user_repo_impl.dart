import 'package:docpoint/core/common/data/datasources/current_user_remote_datasources.dart';
import 'package:docpoint/core/common/data/models/current_user_model.dart';
import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/common/domain/repository/current_user_repo.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserRepoImpl implements CurrentUserRepo {
  final CurrentUserRemoteDatasources _currentUserRemoteDatasources;

  CurrentUserRepoImpl(this._currentUserRemoteDatasources);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final currentUserData =
          await _currentUserRemoteDatasources.getCurrentUserData();
      return right(currentUserData.toUserEntity());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
