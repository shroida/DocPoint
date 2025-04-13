import 'package:docpoint/core/common/domain/entites/user.dart' as current_user;
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:docpoint/features/login/data/models/user_login_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class LoginDatasources {
  Future<UserLoginModel> login(
      {required String email, required String password});
}

class LoginDatasourcesImpl implements LoginDatasources {
  final SupabaseClient _supabaseClient;
  final CurrentUserCubit currentUserCubit;
  LoginDatasourcesImpl(this._supabaseClient, this.currentUserCubit);
  @override
  Future<UserLoginModel> login(
      {required String email, required String password}) async {
    try {
      // 1. Authenticate with Supabase
      final response = await _supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      final user = response.user!;
      final userId = user.id;
      // 2. Fetch user profile based on user type
      final profileData = await _fetchUserProfile(userId, user.email!);

      // 3. Update CurrentUserCubit
      if (currentUserCubit.userType == 'Doctor') {
        currentUserCubit.updateUser(current_user.User(
          id: userId,
          password: '',
          email: user.email ?? email,
          firstName: profileData['first_name'] ?? '',
          lastName: profileData['last_name'],
          phoneNumber: profileData['phone_number'],
          city: profileData['city'],
          imageUrl: profileData['avatar_url'],
          experience: profileData['experience']?.toInt(),
          category: profileData['category'],
          userType: profileData['user_type'] ?? 'Patient',
        ));
        
      }
    } catch (e) {
      throw const ServerExceptions('Error Login');
    }
  }
    Future<Map<String, dynamic>> _fetchUserProfile(String userId, String email) async {
    // Check if user exists in profiles table
    final profileResponse = await _supabaseClient
        .from('user_profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (profileResponse != null) {
      return profileResponse;
    }

    // If no profile exists, create a basic one
    return {
      'first_name': email.split('@').first,
      'last_name': null,
      'phone_number': null,
      'city': null,
      'image_url': null,
      'experience': null,
      'category': null,
      'user_type': 'Patient',
    };
  }

}
