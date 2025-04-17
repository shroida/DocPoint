import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({
    super.key,
    required this.doctor,
    this.showButton,
  });

  final User doctor;
  final bool? showButton;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and Category
          Row(
            children: [
              Expanded(
                child: Text(
                  'Dr. ${doctor.firstName} ${doctor.lastName}',
                  style: AppStyle.heading2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  doctor.category ?? 'General',
                  style: AppStyle.caption.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Experience
          Row(
            children: [
              const Icon(
                Icons.work_outline,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 4),
              Text(
                '${doctor.experience ?? 0}+ years experience',
                style: AppStyle.body1,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Contact Info
          InfoRow(
            icon: Icons.email_outlined,
            text: doctor.email,
          ),
          const SizedBox(height: 4),
          InfoRow(
            icon: Icons.phone_outlined,
            text: doctor.phoneNumber ?? 'Not provided',
          ),
          const SizedBox(height: 4),
          InfoRow(
            icon: Icons.location_on_outlined,
            text: doctor.city ?? 'Location not specified',
          ),
          const SizedBox(height: 12),
          if (showButton != false && showButton == null)

            // Book Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, // Set your primary color
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(50), // Rounded left side
                      right: Radius.circular(50), // Rounded right side
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 7.h, horizontal: 12), // Smaller height
                ),
                onPressed: () {
                  context.push(
                    Routes.makeAppointment,
                    extra: doctor,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                          6), // Padding to make the icon fit in a circle
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape:
                            BoxShape.circle, // Circular background for the icon
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        color:
                            AppColors.primary, // Change icon color if necessary
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Book Appointment',
                      style: AppStyle.button.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppStyle.body2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
