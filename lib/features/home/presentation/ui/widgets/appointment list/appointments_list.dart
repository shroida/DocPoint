import 'package:docpoint/features/home/presentation/ui/widgets/appointment%20list/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';

class AppointmentsList extends StatelessWidget {
  final List<AppointmentEntity> appointments;
  final String userType;
  final Future<void> Function() onRefresh;

  const AppointmentsList({
    super.key,
    required this.appointments,
    required this.userType,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return DetailedAppointmentCard(
            appointment: appointments[index],
            userType: userType,
            onStatusUpdated: onRefresh,
          );
        },
      ),
    );
  }
}
