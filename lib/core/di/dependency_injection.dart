import 'package:docpoint/core/common/data/datasources/current_user_remote_datasources.dart';
import 'package:docpoint/core/common/data/repositories/current_user_repo_impl.dart';
import 'package:docpoint/core/common/domain/repository/current_user_repo.dart';
import 'package:docpoint/core/common/domain/usecase/current_user_usecase.dart';
import 'package:docpoint/core/common/domain/usecase/logout_usecase.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/constants/constants.dart';
import 'package:docpoint/core/network/conntection_checker.dart';
import 'package:docpoint/features/home/data/datasources/get_all_doctors_datasources.dart';
import 'package:docpoint/features/home/data/datasources/local_get_all_doctors_datasource.dart';
import 'package:docpoint/features/home/data/repositories/get_all_doctors_repo_impl.dart';
import 'package:docpoint/features/home/domain/repositories/doctors_repo.dart';
import 'package:docpoint/features/home/domain/usecase/get_all_appointments.dart';
import 'package:docpoint/features/home/domain/usecase/get_all_doctors.dart';
import 'package:docpoint/features/home/domain/usecase/make_appointment.dart';
import 'package:docpoint/features/home/domain/usecase/paid_successed.dart';
import 'package:docpoint/features/home/domain/usecase/update_status_usecase.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_cubit.dart';
import 'package:docpoint/features/login/data/datasources/login_datasources.dart';
import 'package:docpoint/features/login/data/repositories/login_repo_impl.dart';
import 'package:docpoint/features/login/domain/repository/login_repo.dart';
import 'package:docpoint/features/login/domain/usecase/user_login_usecase.dart';
import 'package:docpoint/features/login/presentation/logic/login_cubit.dart';
import 'package:docpoint/features/messages/data/datasource/messages_datasource.dart';
import 'package:docpoint/features/messages/data/repositories/messages_repo_impl.dart';
import 'package:docpoint/features/messages/domain/repositories/messages_repo.dart';
import 'package:docpoint/features/messages/domain/usecase/get_all_messages_usecase.dart';
import 'package:docpoint/features/messages/domain/usecase/make_messages_read.dart';
import 'package:docpoint/features/messages/domain/usecase/send_message_usecase.dart';
import 'package:docpoint/features/messages/presentation/logic/message_cubit.dart';
import 'package:docpoint/features/signup/data/datasources/sign_up_remote_datasource.dart';
import 'package:docpoint/features/signup/data/repositories/sign_up_repo_impl.dart';
import 'package:docpoint/features/signup/domain/repository/sign_up_repo.dart';
import 'package:docpoint/features/signup/domain/usecase/user_sign_up_usecase.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  // Signup related dependencies
  await supabaseDI();
  // Auth related dependencies
  authDI();
  // Signup related dependencies
  signUpDI();
  // login related dependencies
  loginDI();
  // Home page related dependencies
  homePageDI();
  // Chat page related dependencies
  messagesDI();
  // Hive related dependencies
  await boxDI();
}

Future<void> supabaseDI() async {
  final supabase = await Supabase.initialize(url: projectURL, anonKey: anonKey);
  getIt.registerFactory(() => supabase.client);
}

void signUpDI() {
  getIt.registerFactory<SignUpRemoteDatasource>(
      () => SignUpRemoteDatasourceImpl(getIt(), getIt()));
  getIt.registerFactory<SignUpRepo>(() => SignUpRepoImpl(getIt()));
  getIt.registerFactory<UserSignUpUsecase>(() => UserSignUpUsecase(getIt()));
  getIt.registerFactory<SignupCubit>(
      () => SignupCubit((getIt<UserSignUpUsecase>()), getIt(), getIt()));
}

void loginDI() {
  getIt.registerFactory<LoginDatasources>(
      () => LoginDatasourcesImpl(getIt(), getIt()));
  getIt.registerFactory<LoginRepo>(() => LoginRepoImpl(getIt()));
  getIt.registerFactory<UserLoginUsecase>(() => UserLoginUsecase(getIt()));
  getIt
      .registerFactory<LoginCubit>(() => LoginCubit(getIt(), getIt(), getIt()));
}

void authDI() {
  getIt.registerFactory<CurrentUserRemoteDatasources>(
    () => CurrentUserRemoteDatasourcesImpl(getIt()),
  );
  getIt.registerFactory<CurrentUserRepo>(
    () => CurrentUserRepoImpl(getIt()),
  );
  getIt.registerFactory<CurrentUserUsecase>(
    () => CurrentUserUsecase(getIt()),
  );
  getIt.registerFactory<LogoutUsecase>(
    () => LogoutUsecase(getIt()),
  );
  getIt.registerFactory<CurrentUserCubit>(
    () => CurrentUserCubit(getIt(), getIt()),
  );
}

void homePageDI() {
  getIt.registerFactory<GetAllDoctorsDatasources>(
    () => GetAllDoctorsDatasourcesImpl(
      getIt(),
    ),
  );
  getIt.registerFactory<LocalGetAllDoctorsDatasource>(
    () => LocalGetAllDoctorsDatasourceImpl(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<InternetConnection>(() => InternetConnection());

  getIt.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(getIt<InternetConnection>()));

  getIt.registerFactory<GetAllDoctorsRepo>(
    () => GetAllDoctorsRepoImpl(getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<GetAllDoctors>(
    () => GetAllDoctors(
      getIt(),
    ),
  );
  getIt.registerFactory<GetAllAppointments>(
    () => GetAllAppointments(
      getIt(),
    ),
  );
  getIt.registerFactory<MakeAppointment>(
    () => MakeAppointment(
      getIt(),
    ),
  );
  getIt.registerFactory<UpdateStatusUsecase>(
    () => UpdateStatusUsecase(getIt()),
  );
  getIt.registerFactory<PaidSuccessed>(
    () => PaidSuccessed(getIt()),
  );
  getIt.registerFactory<HomePageCubit>(
      () => HomePageCubit(getIt(), getIt(), getIt(), getIt(), getIt()));
}

void messagesDI() {
  getIt.registerFactory<MessagesDatasource>(
    () => MessagesDatasourceImpl(getIt()),
  );
  getIt.registerFactory<MessagesRepo>(
    () => MessagesRepoImpl(getIt()),
  );

  getIt.registerFactory<SendMessageUsecase>(
    () => SendMessageUsecase(getIt()),
  );

  getIt.registerFactory<GetAllMessagesUsecase>(
    () => GetAllMessagesUsecase(getIt()),
  );
  getIt.registerFactory<MakeMessagesRead>(
    () => MakeMessagesRead(getIt()),
  );
  getIt.registerFactory<MessageCubit>(
    () => MessageCubit(getIt(), getIt(), getIt()),
  );
}

Future<void> boxDI() async {
  await Hive.initFlutter();
  final box = await Hive.openBox('DoctorsBox');
  getIt.registerLazySingleton<Box>(() => box);
}
