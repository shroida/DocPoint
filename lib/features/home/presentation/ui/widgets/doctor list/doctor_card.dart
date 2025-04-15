import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/doctor%20list/doctor_details.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/doctor%20list/doctor_image.dart';
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
        decoration: _containerDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              DoctorImage(doctor: doctor),
              const SizedBox(width: 16),
              // Doctor Details
              DoctorDetails(doctor: doctor),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.primaryLight,
          AppColors.primary.withOpacity(0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
