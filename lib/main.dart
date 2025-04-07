import 'package:docpoint/core/constants/constants.dart';
import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/doc_point.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: projectURL, anonKey: anonKey);

  final appRouter = AppRouter().router;
  runApp(DocPoint(
    appRouter: appRouter,
  ));
}
