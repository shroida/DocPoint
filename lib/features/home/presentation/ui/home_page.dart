import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/features/home/presentation/ui/pages/appointments_screen.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/custom_app_bar.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/custom_drawer.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/doctor%20list/doctor_list_screen.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadUserData();

      final cubit = context.read<CurrentUserCubit>();
      if (cubit.currentUser != null) {
        // Manually emit the state again in case it's missed
        context.read<CurrentUserCubit>().emit(
              CurrentUserAuthenticated(cubit.currentUser!),
            );
      }
    });
  }

  Future<void> _loadUserData() async {
    try {
      await context.read<CurrentUserCubit>().checkAuthStatus();
    } catch (e) {
      ServerExceptions('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: scaffoldKey,
        title: 'Home',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.surface),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.surface),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        builder: (context, state) {
          if (state is CurrentUserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CurrentUserAuthenticated) {
            final currentUserCubit = context.read<CurrentUserCubit>();
            if (currentUserCubit.currentUser == null) {
              return const Center(child: Text('User data not available'));
            }
            return currentUserCubit.userType == "Patient"
                ? SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          const UserInfoCard(),
                          SizedBox(
                            height: 20.h,
                          ),

                          const DoctorsListScreen(),

                          Text(currentUserCubit.currentUser!.email),
                          // Add other user data here
                        ],
                      ),
                    ),
                  )
                : AppointmentsScreen(
                    userId: currentUserCubit.currentUser!.id,
                    userType: "Doctor");
          }

          if (state is CurrentUserError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const Center(child: Text('Please login'));
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clear focus when widget is disposed
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }
}
