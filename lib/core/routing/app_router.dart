import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/di/dependency_injection.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_cubit.dart';
import 'package:docpoint/features/home/presentation/ui/home_page.dart';
import 'package:docpoint/features/home/presentation/ui/pages/appointments_screen.dart';
import 'package:docpoint/features/home/presentation/ui/pages/make_appointment_screen.dart';
import 'package:docpoint/features/login/presentation/logic/login_cubit.dart';
import 'package:docpoint/features/login/presentation/login_screen.dart';
import 'package:docpoint/features/onboadring/onboarding_screen.dart';
import 'package:docpoint/features/signup/presentation/logic/cubit/signup_cubit.dart';
import 'package:docpoint/features/signup/presentation/ui/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: Routes.onBoardingScreen,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: Routes.makeAppointment,
      builder: (context, state) {
        final doctor = state.extra as User;
        return BlocProvider<HomePageCubit>(
          create: (context) =>
              getIt<HomePageCubit>(), // Create the provider here
          child: MakeAppointmentScreen(
            doctor: doctor,
            patientId: context.read<CurrentUserCubit>().currentUser!.id,
          ),
        );
      },
    ),
    GoRoute(
      path: Routes.appointmentPage,
      builder: (context, state) {
        final extra = state.extra as AppointmentPageArgs;
        return BlocProvider(
          create: (_) => getIt<HomePageCubit>(),
          child: AppointmentsScreen(
            userId: extra.userId,
            userType: extra.userType,
          ),
        );
      },
    ),
    GoRoute(
        path: Routes.homePage,
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<HomePageCubit>(),
              child: const HomePage(),
            )),
    GoRoute(
        path: Routes.loginScreen,
        builder: (context, state) => BlocProvider(
              create: (_) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            )),
    GoRoute(
        path: Routes.signupScreen,
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<SignupCubit>(),
              child: const SignupScreen(),
            )),
  ], initialLocation: Routes.onBoardingScreen);
}

class AppointmentPageArgs {
  final String userId;
  final String userType;

  AppointmentPageArgs({
    required this.userId,
    required this.userType,
  });
}
