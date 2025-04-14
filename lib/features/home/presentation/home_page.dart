import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:docpoint/features/home/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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

  @override
  void dispose() {
    // Clear focus when widget is disposed
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }
}
