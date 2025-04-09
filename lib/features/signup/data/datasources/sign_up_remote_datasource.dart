import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:docpoint/features/signup/data/models/user_sign_up_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SignUpRemoteDatasource {
  Future<UserSignUpModel> signUp(
      {required String email,
      String? imageUrl,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String city});
}

class SignUpRemoteDatasourceImpl implements SignUpRemoteDatasource {
  final SupabaseClient supabaseClient;

  SignUpRemoteDatasourceImpl(this.supabaseClient);
  @override
  Future<UserSignUpModel> signUp(
      {required String email,
      String? imageUrl,
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
      'avatar_url': imageUrl ?? '',
    });
    if (resppnse.user == null) {
      throw const ServerExceptions('User is null');
    }
    return UserSignUpModel.fromJson(resppnse.user!.toJson());
  }
}
