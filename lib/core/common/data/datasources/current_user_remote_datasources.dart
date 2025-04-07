import 'package:docpoint/core/common/data/models/current_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CurrentUserRemoteDatasources {
  Session? get currentUserSession;
  Future<CurrentUserModel> getCurrentUserData();
}

class CurrentUserRemoteDatasourcesImpl implements CurrentUserRemoteDatasources {
  final SupabaseClient supabaseClient;

  CurrentUserRemoteDatasourcesImpl(this.supabaseClient);
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<CurrentUserModel> getCurrentUserData() {
    // TODO: implement getCurrentUserData
    throw UnimplementedError(); 
  }
}
