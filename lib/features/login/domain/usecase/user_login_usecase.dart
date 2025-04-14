import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/login/domain/repository/login_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginUsecase implements UseCase<User, LoginParams> {
  final LoginRepo _loginRepo;

  UserLoginUsecase(this._loginRepo);
  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return _loginRepo.login(email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
