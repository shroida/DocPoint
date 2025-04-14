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

      // First check if user is a doctor
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
          'email': session.user.email,
        });
      }
      // If not a doctor, check if patient
      final patientResponse = await supabaseClient
          .from('patient_profiles')
          .select()
          .eq('id', userId)
          .single();
      isLoggedInUser = true;

      return CurrentUserModel.fromJson({
        ...patientResponse,
        'user_type': 'patient',
        'email': session.user.email,
      });
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }

  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }
}
