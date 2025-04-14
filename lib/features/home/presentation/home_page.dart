import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:docpoint/features/home/presentation/widgets/custom_drawer.dart';
import 'package:docpoint/features/home/presentation/widgets/doctor_list_screen.dart';
import 'package:docpoint/features/home/presentation/widgets/user_info_card.dart';
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    UserInfoCard(),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Adjust height as needed
                    DoctorsListScreen(),

                    Text(currentUser.email),
                    // Add other user data here
                  ],
                ),
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
