import 'package:docpoint/core/common/data/models/current_user_model.dart';
import 'package:docpoint/core/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CurrentUserRemoteDatasources {
  Session? get currentUserSession;
  Future<CurrentUserModel> getCurrentUserData();
  Future<void> logout();
}

class CurrentUserRemoteDatasourcesImpl implements CurrentUserRemoteDatasources {
  final SupabaseClient supabaseClient;

  CurrentUserRemoteDatasourcesImpl(this.supabaseClient);
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;
  @override
  Future<CurrentUserModel> getCurrentUserData() async {
    try {
      final session = currentUserSession;

      if (session == null) {
        throw Exception('No active session');
      }

      final userId = session.user.id;
      final userEmail = session.user.email;

      final doctorResponse = await supabaseClient
          .from('doctor_profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (doctorResponse != null) {
        isLoggedInUser = true;
        return CurrentUserModel.fromJson({
          ...doctorResponse,
          'user_type': 'doctor',
          'email': userEmail,
        });
      }

      final patientQuery = await supabaseClient
          .from('patient_profiles')
          .select()
          .eq('id', userId);

      if (patientQuery.length == 1) {
        final patientResponse = patientQuery.first;
        isLoggedInUser = true;
        return CurrentUserModel.fromJson({
          ...patientResponse,
          'user_type': 'patient',
          'email': userEmail,
        });
      } else if (patientQuery.isEmpty) {
        throw Exception('User not found in patient_profiles');
      } else {
        throw Exception(
            'Multiple users found with same ID in patient_profiles');
      }
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabaseClient.auth.signOut();

      await supabaseClient.removeAllChannels();

      if (supabaseClient.auth.currentSession != null) {
        throw Exception('Session still exists after logout');
      }
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
}
