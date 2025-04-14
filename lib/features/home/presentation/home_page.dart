import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:docpoint/features/home/presentation/widgets/custom_drawer.dart';
import 'package:docpoint/features/login/presentation/widgets/logo_login.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    try {
      await context.read<CurrentUserCubit>().checkAuthStatus();
    } catch (e) {
      debugPrint('Error loading user data: $e');
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
            final currentUser = context.read<CurrentUserCubit>().currentUser;
            if (currentUser == null) {
              return const Center(child: Text('User data not available'));
            }

            return SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Profile Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: currentUser.imageUrl != null
                              ? Image.network(
                                  currentUser.imageUrl!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error, size: 80),
                                )
                              : const Icon(Icons.person,
                                  size: 80, color: Colors.white),
                        ),
                        const SizedBox(width: 15),

                        // Info Column
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${currentUser.firstName} ${currentUser.lastName ?? ''}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16, color: Colors.white70),
                                  const SizedBox(width: 4),
                                  Text(
                                    currentUser.city ?? 'Unknown City',
                                    style:
                                        const TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                          width: 100,
                          child: LogoLogin(),
                        ),
                      ],
                    ),
                  ),

                  Text(currentUser.email),
                  // Add other user data here
                ],
              ),
            );
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
