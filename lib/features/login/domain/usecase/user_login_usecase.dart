import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/login/domain/repository/login_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginUsecase implements UseCase<User, UserLogiParams> {
  final LoginRepo _loginRepo;

  UserLoginUsecase(this._loginRepo);
  @override
  Future<Either<Failure, User>> call(UserLogiParams params) async {
    return _loginRepo.login(
        email: params.email,
        password: params.password,
        firstName: params.firstName,
        lastName: params.lastName,
        phoneNumber: params.phoneNumber,
        city: params.city);
  }
}

class UserLogiParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String city;

  UserLogiParams(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.city});
}
