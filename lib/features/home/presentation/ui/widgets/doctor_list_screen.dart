import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:flutter/material.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';

class DoctorsListScreen extends StatelessWidget {
  final List<User> doctors = [
    User(
      id: '1',
      email: 'dr.smith@example.com',
      firstName: 'John',
      lastName: 'Smith',
      phoneNumber: '+1234567890',
      city: 'New York',
      imageUrl: 'https://example.com/doctor1.jpg',
      experience: 10,
      category: 'Cardiologist',
      userType: 'Doctor',
    ),
    User(
      id: '1',
      email: 'dr.smith@example.com',
      firstName: 'John',
      lastName: 'Smith',
      phoneNumber: '+1234567890',
      city: 'New York',
      imageUrl: 'https://example.com/doctor1.jpg',
      experience: 10,
      category: 'Cardiologist',
      userType: 'Doctor',
    ),
    User(
      id: '1',
      email: 'dr.smith@example.com',
      firstName: 'John',
      lastName: 'Smith',
      phoneNumber: '+1234567890',
      city: 'New York',
      imageUrl: 'https://example.com/doctor1.jpg',
      experience: 10,
      category: 'Cardiologist',
      userType: 'Doctor',
    ),
    User(
      id: '1',
      email: 'dr.smith@example.com',
      firstName: 'John',
      lastName: 'Smith',
      phoneNumber: '+1234567890',
      city: 'New York',
      imageUrl: 'https://example.com/doctor1.jpg',
      experience: 10,
      category: 'Cardiologist',
      userType: 'Doctor',
    ),

    // Add more doctors...
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: doctors.map((doctor) => DoctorCard(doctor: doctor)).toList(),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final User doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.primary.withOpacity(0.05),
            ],
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
                        Text(
                          'Dr. ${doctor.firstName} ${doctor.lastName}',
                          style: AppStyle.heading3.copyWith(
                            color: AppColors.primaryDark,
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
                          style: AppStyle.body2,
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                        ),
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
