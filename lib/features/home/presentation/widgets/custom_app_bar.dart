import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final ScaffoldState? scaffoldState; // Changed from GlobalKey<ScaffoldState>

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.scaffoldState, // Changed parameter
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          if (scaffoldState != null) {
            scaffoldState!.openDrawer();
          } else {
            Scaffold.of(context).openDrawer();
          }
        },
      ),
      title: Text(
        title,
        style: AppStyle.heading2.copyWith(color: Colors.white),
      ),
      backgroundColor: AppColors.primary,
      elevation: 4,
      actions: actions,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.0),
        ),
      ),
      toolbarHeight: 56.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
