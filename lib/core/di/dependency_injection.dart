import 'package:docpoint/features/signup/domain/usecase/user_sign_up_usecase.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  getIt.registerFactory<UserSignUpUsecase>(() => UserSignUpUsecase(getIt()));
  getIt.registerLazySingleton<SignupCubit>(
      () => SignupCubit((getIt<UserSignUpUsecase>())));
}
