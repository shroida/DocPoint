import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/features/home/presentation/ui/pages/appointments_screen.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/custom_app_bar.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/custom_drawer.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/doctor%20list/doctor_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0; // ✅ Moved here!

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadUserData();
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
    final currentUser = context.read<CurrentUserCubit>().currentUser;

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: scaffoldKey,
        image: currentUser!.imageUrl ?? '',
        city: currentUser.city ?? '',
        name: '${currentUser.firstName} ${currentUser.lastName} ',
        title: 'Home',
      ),
      drawer: const CustomDrawer(),
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex, // ✅ Let GNav reflect selected tab
        padding: const EdgeInsets.all(10),
        gap: 6,
        tabMargin: EdgeInsets.symmetric(vertical: 10, horizontal: 10.w),
        activeColor: AppColors.primary,
        backgroundColor: Colors.white,
        tabBackgroundColor: const Color(0xFFEBEBEB),
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              context.pushReplacement(Routes.homePage);
              break;
            case 1:
              context
                  .push(
                Routes.chatListType,
              )
                  .then((_) {
                setState(() {
                  _selectedIndex = 0;
                });
              });
              break;
            case 2:
              context
                  .push(
                Routes.appointmentPage,
                extra: AppointmentPageArgs(
                  userId: context.read<CurrentUserCubit>().currentUser!.id,
                  userType: context.read<CurrentUserCubit>().userType,
                ),
              )
                  .then((_) {
                setState(() {
                  _selectedIndex = 0; // ✅ Force go back to Home on return
                });
              });
              break;
            case 3:
              context.push(Routes.profilePage, extra: currentUser);
              break;
          }
        },
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.messenger_rounded, text: 'Messages'),
          GButton(icon: Icons.calendar_month, text: 'Appointments'),
          GButton(icon: Icons.person, text: 'Profile'),
        ],
      ),
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
                          SizedBox(height: 20.h),
                          const DoctorsListScreen(),
                        ],
                      ),
                    ),
                  )
                : AppointmentsScreen(
                    userId: currentUserCubit.currentUser!.id,
                    userType: "Doctor",
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
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }
}
