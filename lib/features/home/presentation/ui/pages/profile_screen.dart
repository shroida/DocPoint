import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:docpoint/core/common/domain/entites/user.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isDoctor = user.category != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Profile",
            style: AppStyle.heading2.copyWith(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundImage: NetworkImage(user.imageUrl ?? ''),
              ),
              SizedBox(height: 16.h),
              Text("${user.firstName} ${user.lastName}",
                  style: AppStyle.heading2),
              Text(user.email, style: AppStyle.caption),
              SizedBox(height: 24.h),
              _profileItem("Phone Number", user.phoneNumber ?? ''),
              _profileItem("City", user.city ?? ''),
              if (isDoctor) ...[
                _profileItem("Category", user.category ?? ''),
                _profileItem("Experience", "${(user).experience} years"),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileItem(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.r,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyle.body1),
          Text(value, style: AppStyle.body2),
        ],
      ),
    );
  }
}
