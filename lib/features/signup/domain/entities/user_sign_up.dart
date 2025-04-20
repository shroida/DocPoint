import 'package:docpoint/core/common/domain/entities/user.dart';

class UserSignUp extends User {
  UserSignUp(
      {required super.email,
      super.password,
      required super.firstName,
      super.category,
      super.experience,
      required super.imageUrl,
      required super.userType,
      required super.id,
      required super.lastName,
      required super.phoneNumber,
      required super.city});
}
