import 'package:docpoint/core/di/dependency_injection.dart';
import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/doc_point.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpGetIt();

  final appRouter = AppRouter().router;
  runApp(DocPoint(
    appRouter: appRouter,
  ));
}
