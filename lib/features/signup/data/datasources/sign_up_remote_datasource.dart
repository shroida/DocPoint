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
      required String userType,
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
      required String userType,
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
      'avatar_url': imageUrl,
      'user_type': userType,
      if (userType == 'Doctor') ...{
        'experience': experience ?? 0,
        'category': category ?? '',
      },
    });
    final userId = response.user!.id;

    if (userType == 'Doctor') {
      await supabaseClient.from('doctor_profiles').insert({
        'id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'city': city,
        'avatar_url': imageUrl,
        'category': category ?? '',
        'experience': experience ?? 0,
      });
    } else {
      await supabaseClient.from('patient_profiles').insert({
        'id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'city': city,
        'avatar_url': imageUrl,
      });
    }
    if (response.user == null) {
      throw const ServerExceptions('User is null');
    }
    return UserSignUpModel.fromJson(response.user!.toJson());
  }
}
