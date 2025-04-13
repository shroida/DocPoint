import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
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
  final CurrentUserCubit currentUserCubit;

  SignUpRemoteDatasourceImpl(this.supabaseClient, this.currentUserCubit);

  @override
  Future<UserSignUpModel> signUp({
    required String email,
    required String imageUrl,
    int? experience,
    String? category,
    required String password,
    required String userType,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String city,
  }) async {
    try {
      // 1. Sign up with Supabase Auth
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'first_name': firstName,
          'email': email,
          'last_name': lastName,
          'phone_number': phoneNumber,
          'city': city,
          'avatar_url': imageUrl,
          'user_type': userType,
          if (userType == 'Doctor') ...{
            'experience': experience ?? 0,
            'category': category ?? '',
          },
        },
      );

      if (response.user == null) {
        throw const ServerExceptions('User registration failed');
      }

      final userId = response.user!.id;

      // 2. Create profile based on user type
      await _createUserProfile(
        userId: userId,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        city: city,
        imageUrl: imageUrl,
        userType: userType,
        experience: experience,
        category: category,
      );

      // 3. Update current user cubit
      currentUserCubit.updateUser(UserSignUpModel(
        id: userId,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        city: city,
        imageUrl: imageUrl,
        experience: experience,
        category: category,
        userType: userType,
      ));

      return UserSignUpModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  Future<void> _createUserProfile({
    required String userId,
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String city,
    required String imageUrl,
    required String userType,
    int? experience,
    String? category,
  }) async {
    final profileData = {
      'id': userId,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'city': city,
      'avatar_url': imageUrl,
    };

    if (userType == 'Doctor') {
      await supabaseClient.from('doctor_profiles').insert({
        ...profileData,
        'experience': experience ?? 0,
        'category': category ?? '',
      });
    } else {
      await supabaseClient.from('patient_profiles').insert(profileData);
    }
  }
}
