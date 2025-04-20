import 'package:docpoint/core/common/logic/cubit/current_user_state.dart';
import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/routing/app_router.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        final currentUserCubit = context.read<CurrentUserCubit>();

        if (state is CurrentUserLoading ||
            currentUserCubit.currentUser == null) {
          return const Drawer(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Drawer(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          child: FocusScope(
            canRequestFocus: false,
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // User Profile Section
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
                      color: AppColors.primary,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                currentUserCubit.currentUser!.imageUrl ?? ''),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${currentUserCubit.userType == 'Doctor' ? 'Doc' : ''} ${currentUserCubit.currentUser!.firstName} ${currentUserCubit.currentUser!.lastName}', // Replace with user's name
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            currentUserCubit.currentUser!.email,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Menu Items
                    Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.home_outlined,
                              color: AppColors.primary),
                          title: const Text('Home',
                              style: TextStyle(color: Colors.black)),
                          onTap: () {},
                        ),
                        if (currentUserCubit.userType == 'Patient')
                          ListTile(
                            leading: const Icon(Icons.calendar_today,
                                color: AppColors.primary),
                            title: const Text('Appointment',
                                style: TextStyle(color: Colors.black)),
                            onTap: () {
                              context.push(
                                Routes.appointmentPage,
                                extra: AppointmentPageArgs(
                                  true,
                                  userId: context
                                      .read<CurrentUserCubit>()
                                      .currentUser!
                                      .id,
                                  userType:
                                      context.read<CurrentUserCubit>().userType,
                                ),
                              );
                            },
                          ),
                        ListTile(
                          leading: const Icon(Icons.person,
                              color: AppColors.primary),
                          title: const Text('Profile',
                              style: TextStyle(color: Colors.black)),
                          onTap: () {
                            context.push(Routes.profilePage,
                                extra: context
                                    .read<CurrentUserCubit>()
                                    .currentUser);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.notifications,
                              color: AppColors.primary),
                          title: const Text('Notifications',
                              style: TextStyle(color: Colors.black)),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings,
                              color: AppColors.primary),
                          title: const Text('Settings',
                              style: TextStyle(color: Colors.black)),
                          onTap: () {},
                        ),
                      ],
                    ),

                    // Divider
                    Divider(thickness: 1, color: Colors.grey[300]),
                    ListTile(
                      leading: const Icon(Icons.logout,
                          color: Colors.red), // Red icon for logout
                      title: const Text('Logout',
                          style: TextStyle(color: Colors.red)),
                      onTap: () async {
                        await currentUserCubit.logout();
                        Future.microtask(() {
                          if (!context.mounted) return;
                          context.go(Routes.loginScreen); // or pushReplacement
                        });
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
