import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocPoint extends StatelessWidget {
  const DocPoint({super.key, required this.appRouter});

  final GoRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: appRouter.routeInformationParser,
      routerDelegate: appRouter.routerDelegate,
      routeInformationProvider: appRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}
