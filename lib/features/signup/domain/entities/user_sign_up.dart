import 'package:docpoint/core/common/domain/entites/user.dart';

class UserSignUp extends User {
  UserSignUp(
      {required super.email,
      required super.password,
      required super.firstName,
      required super.lastName,
      required super.phoneNumber,
      required super.city});
}
