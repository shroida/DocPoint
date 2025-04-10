import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:docpoint/features/signup/data/models/user_sign_up_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SignUpRemoteDatasource {
  Future<UserSignUpModel> signUp(
      {required String email,
      required String imageUrl,
      String? category,
      int? experience,
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
      required String imageUrl,
      int? experience,
      String? category,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required String city}) async {
    final response = await supabaseClient.auth
        .signUp(email: email, password: password, data: {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'city': city,
      'experience': experience ?? 0,
      'category': category ?? '',
      'avatar_url': imageUrl,
    });
    final userId = response.user!.id;

    // 2. Insert into patient_profiles table
    await supabaseClient.from('patient_profiles').insert({
      'id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'city': city,
      'avatar_url': imageUrl,
      'experience': experience,
      'category': category ?? '',
    });
    if (response.user == null) {
      throw const ServerExceptions('User is null');
    }
    return UserSignUpModel.fromJson(response.user!.toJson());
  }
}
