import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/features/signup/data/models/user_login_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class LoginRemoteDatasource {
  Future<UserLoginModel> login(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String city});
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final SupabaseClient supabaseClient;

  LoginRemoteDatasourceImpl(this.supabaseClient);
  @override
  Future<UserLoginModel> login(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String city}) async {
    final resppnse = await supabaseClient.auth
        .signUp(email: email, password: password, data: {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'city': city,
    });
    if (resppnse.user == null) {
      throw Failure('error');
    }
  }
}
