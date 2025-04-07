import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class LoginRepo {
  Future<Either<Failure, User>> login(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String city});
}
