import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/doctor%20list/doctor_list_screen.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final User doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryLight,
              AppColors.primary.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: doctor.imageUrl != null
                      ? Image.network(
                          doctor.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.person,
                            size: 40,
                            color: AppColors.primary,
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 40,
                          color: AppColors.primary,
                        ),
                ),
              ),
              const SizedBox(width: 16),
              // Doctor Details
              Expanded(
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
                    // Book Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: AppStyle.primaryButton,
                        onPressed: () {
                          // Handle booking
                        },
                        child: Text(
                          'Book Appointment',
                          style: AppStyle.button.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
