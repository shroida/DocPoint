import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:docpoint/features/signup/data/datasources/sign_up_remote_datasource.dart';
import 'package:docpoint/features/signup/domain/repository/sign_up_repo.dart';
import 'package:fpdart/fpdart.dart';

class SignUpRepoImpl implements SignUpRepo {
  final SignUpRemoteDatasource _signUpRemoteDatasource;

  SignUpRepoImpl(this._signUpRemoteDatasource);
  @override
  Future<Either<Failure, User>> signUp(
      {required String email,
      required String imageUrl,
      required String password,
      int? experience,
      String? category,
      required String userType,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String city}) async {
    try {
      final user = await _signUpRemoteDatasource.signUp(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          imageUrl: imageUrl,
          experience: experience ?? 0,
          category: category ?? '',
          city: city,
          userType: userType);

      return right(user);
    } on ServerExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
