import 'package:docpoint/core/common/domain/entities/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class LoginRepo {
  Future<Either<Failure, User>> login(
      {required String email, required String password});
}
