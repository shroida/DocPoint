import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CurrentUserRepo {
  Future<Either<Failure, User>> currentUser();
}
