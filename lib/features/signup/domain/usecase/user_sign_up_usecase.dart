import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/signup/domain/repository/sign_up_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUpRepoUsecase implements UseCase<User, UserSignUpParams> {
  final SignUpRepo _signUpRepo;

  UserSignUpRepoUsecase(this._signUpRepo);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return _signUpRepo.signUp(
        email: params.email,
        password: params.password,
        firstName: params.firstName,
        lastName: params.lastName,
        phoneNumber: params.phoneNumber,
        city: params.city);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String city;

  UserSignUpParams(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.city});
}
