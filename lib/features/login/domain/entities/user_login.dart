import 'package:docpoint/core/common/domain/entities/user.dart';

class UserLogin extends User {
  UserLogin(
      {required super.email,
      required super.password,
      required super.id,
      super.firstName = '',
      super.lastName,
      super.phoneNumber,
      super.city,
      super.imageUrl,
      super.userType});
}
