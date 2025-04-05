import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/doc_point.dart';
import 'package:flutter/material.dart';

void main() {
  final appRouter = AppRouter().router;
  runApp(DocPoint(
    appRouter: appRouter,
  ));
}
