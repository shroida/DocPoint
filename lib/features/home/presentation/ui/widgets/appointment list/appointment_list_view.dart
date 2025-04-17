import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/domain/usecase/update_status_usecase.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_cubit.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/appointment%20list/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';

class AppointmentListView extends StatelessWidget {
  final List<AppointmentEntity> appointments;
  final Future<void> Function() onRefresh;

  const AppointmentListView({
    super.key,
    required this.appointments,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 60,
              color: AppColors.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No Appointments Yet',
              style: AppStyle.heading3.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Book your first appointment to get started',
              style: AppStyle.body2,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return DetailedAppointmentCard(
            appointment: appointment,
            onStatusUpdated: () async {
              await context.read<HomePageCubit>().updateStatusAppointment(
                    UpdateStatusParams(
                      appointmentId: appointment.id,
                      status: 'confirmed',
                    ),
                  );
              onRefresh(); // refresh after updating status
            },
            userType: context.read<CurrentUserCubit>().userType,
          );
        },
      ),
    );
  }
}
