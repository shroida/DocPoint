import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  getIt.registerLazySingleton<SignupCubit>(() => SignupCubit());
}
