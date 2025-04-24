import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docpoint/core/di/dependency_injection.dart';
import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/features/payment/stripe_service.dart';
import 'package:docpoint/doc_point.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StripeService.init();
  await setUpGetIt();

  final authCubit = getIt<CurrentUserCubit>();
  await authCubit.checkAuthStatus();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.pink, // status bar color
  ));
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
      ],
      child: DocPoint(appRouter: AppRouter().router),
    ),
  );
}
