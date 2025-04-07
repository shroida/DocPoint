import 'package:docpoint/core/constants/constants.dart';
import 'package:docpoint/features/signup/data/datasources/sign_up_remote_datasource.dart';
import 'package:docpoint/features/signup/data/repositories/sign_up_repo_impl.dart';
import 'package:docpoint/features/signup/domain/repository/sign_up_repo.dart';
import 'package:docpoint/features/signup/domain/usecase/user_sign_up_usecase.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  final supabase = await Supabase.initialize(url: projectURL, anonKey: anonKey);

  getIt.registerFactory(() => supabase.client);
  getIt.registerFactory<SignUpRemoteDatasource>(
      () => SignUpRemoteDatasourceImpl(getIt()));
  getIt.registerFactory<SignUpRepo>(() => SignUpRepoImpl(getIt()));
  getIt.registerFactory<UserSignUpUsecase>(() => UserSignUpUsecase(getIt()));
  getIt.registerLazySingleton<SignupCubit>(
      () => SignupCubit((getIt<UserSignUpUsecase>())));
}
