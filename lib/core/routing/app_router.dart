import 'package:docpoint/core/di/dependency_injection.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/features/login/ui/login_screen.dart';
import 'package:docpoint/features/onboadring/onboarding_screen.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:docpoint/features/signup/presentation/ui/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.onBoardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
          path: Routes.loginScreen,
          builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: Routes.signupScreen,
          builder: (context, state) => BlocProvider(
                create: (context) => getIt<SignupCubit>(),
                child: const SignupScreen(),
              )),
    ],
    initialLocation: Routes.onBoardingScreen,
  );
}
