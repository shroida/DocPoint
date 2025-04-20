import 'package:docpoint/core/common/domain/entities/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CurrentUserRepo {
  Future<Either<Failure, User>> currentUser();
  Future<void> logout();
}
