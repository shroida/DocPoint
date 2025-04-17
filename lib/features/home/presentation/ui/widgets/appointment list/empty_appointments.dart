import 'package:flutter/material.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';

class EmptyAppointmentsWidget extends StatelessWidget {
  const EmptyAppointmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today,
              size: 60, color: AppColors.primary.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text('No Appointments Yet',
              style:
                  AppStyle.heading3.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          const Text('Book your first appointment to get started',
              style: AppStyle.body2),
        ],
      ),
    );
  }
}
