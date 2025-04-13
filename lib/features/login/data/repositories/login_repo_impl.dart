import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/features/login/data/datasources/login_datasources.dart';
import 'package:docpoint/features/login/domain/repository/login_repo.dart';
import 'package:fpdart/fpdart.dart';

class LoginRepoImpl implements LoginRepo {
  final LoginDatasources _loginDatasources;

  LoginRepoImpl(this._loginDatasources);
  @override
  Future<Either<Failure, User>> login(
      {required String email, required String password}) async {
    try {
      final user =
          await _loginDatasources.login(email: email, password: password);

      return right(user);
    } catch (e) {}
  }
}
