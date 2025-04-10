import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SignUpRepo {
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String city,
    required String imageUrl,
    required String userType,
    int experience,
    String category,
  });
}
