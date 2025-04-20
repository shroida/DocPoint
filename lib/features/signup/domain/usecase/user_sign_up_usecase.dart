import 'package:docpoint/core/common/domain/entities/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/signup/domain/repository/sign_up_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUpUsecase implements UseCase<User, UserSignUpParams> {
  final SignUpRepo _signUpRepo;

  UserSignUpUsecase(this._signUpRepo);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return _signUpRepo.signUp(
        email: params.email,
        password: params.password,
        firstName: params.firstName,
        lastName: params.lastName,
        phoneNumber: params.phoneNumber,
        city: params.city,
        userType: params.userType,
        category: params.category,
        experience: params.experience,
        imageUrl: params.imageUrl);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String city;
  final String category;
  final int experience;
  final String imageUrl;
  final String userType;

  UserSignUpParams(
      {required this.email,
      required this.password,
      this.category = '',
      this.experience = 0,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.imageUrl,
      required this.userType,
      required this.city});
}
