import 'package:docpoint/core/common/domain/entities/user.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({
    super.key,
    required this.doctor,
  });

  final User doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
