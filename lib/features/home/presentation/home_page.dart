import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:docpoint/features/home/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<CurrentUserCubit>().currentUser;

    return Scaffold(
      key: scaffoldKey, // Assign the key here
      appBar: CustomAppBar(
        scaffoldKey: scaffoldKey, // Pass the key to CustomAppBar
        title: 'Home',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.surface),
            onPressed: () {
              // Handle notification action
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.surface),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: const SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
