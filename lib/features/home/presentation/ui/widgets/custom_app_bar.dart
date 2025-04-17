import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String name;
  final String city;
  final String image;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const CustomAppBar({
    super.key,
    required this.title,
    this.scaffoldKey,
    required this.name,
    required this.city,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          scaffoldKey?.currentState?.openDrawer();
        },
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20.h,
            backgroundImage: NetworkImage(image),
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(width: 12.w),

          // Name and City
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: AppStyle.heading3.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                city,
                style: AppStyle.heading1.copyWith(
                  color: Colors.white70,
                  fontSize: 12.w,
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: AppColors.primary,
      elevation: 6,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: AppColors.surface),
          onPressed: () {},
        ),
      ],
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.0),
        ),
      ),
      toolbarHeight: 80.0.h,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
