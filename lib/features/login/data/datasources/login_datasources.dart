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
      final response = await _supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      final userId = response.user!.id;
    } catch (e) {
      throw const ServerExceptions('Error Login');
    }
  }
}
