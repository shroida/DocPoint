import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:docpoint/features/home/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({super.key});

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
      body: const SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
