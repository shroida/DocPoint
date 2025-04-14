import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserCubit = context.read<CurrentUserCubit>();

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
                            currentUserCubit.currentUser.imageUrl ?? ''),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${currentUserCubit.userType == 'Doctor' ? 'Doc' : ''} ${currentUserCubit.currentUser.firstName} ${currentUserCubit.currentUser.lastName}', // Replace with user's name
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        currentUserCubit.currentUser.email,
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
                          color: AppColors.primary), // Set icon color
                      title: const Text('Home',
                          style:
                              TextStyle(color: Colors.black)), // Set text color
                      onTap: () {
                        // Add navigation logic here
                      },
                    ), // Profile and Logout Section
                    ListTile(
                      leading:
                          const Icon(Icons.person, color: AppColors.primary),
                      title: const Text('Profile',
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        // Add navigation to profile
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.notifications,
                          color: AppColors.primary),
                      title: const Text('Notifications',
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        // Add navigation to profile
                      },
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.settings, color: AppColors.primary),
                      title: const Text('Settings',
                          style: TextStyle(color: Colors.black)),
                      onTap: () {
                        // Add navigation logic here
                      },
                    ),
                  ],
                ),

                // Divider
                Divider(thickness: 1, color: Colors.grey[300]),
                ListTile(
                  leading: const Icon(Icons.logout,
                      color: Colors.red), // Red icon for logout
                  title:
                      const Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    await currentUserCubit.logout();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
