import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/di/dependency_injection.dart';
import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/doc_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpGetIt();

  final appRouter = AppRouter().router;
  runApp(BlocProvider(
    create: (context) => getIt<CurrentUserCubit>()..checkAuthStatus(),
    child: DocPoint(
      appRouter: appRouter,
    ),
  ));
}
