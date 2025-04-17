import 'package:docpoint/features/home/domain/usecase/update_status_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_cubit.dart';

class DetailedAppointmentCard extends StatelessWidget {
  final AppointmentEntity appointment;
  final String userType;
  final VoidCallback onStatusUpdated;

  const DetailedAppointmentCard({
    super.key,
    required this.appointment,
    required this.userType,
    required this.onStatusUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildMainInfo(),
            if (_hasNotes) ...[
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Text(
                'Notes',
                style: AppStyle.body1.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(appointment.notes!, style: AppStyle.body2),
            ],
            if (_showActions) ...[
              const SizedBox(height: 16),
              _buildActionButtons(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatusChip(appointment.status),
        Text(
          DateFormat('MMM dd, yyyy').format(appointment.appointmentTime),
          style: AppStyle.body2.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildMainInfo() {
    return Row(
      children: [
        Container(
          width: 4,
          height: 60,
          decoration: BoxDecoration(
            color: _getStatusColor(appointment.status),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appointment.category, style: AppStyle.heading3),
              const SizedBox(height: 4),
              Text(
                userType == 'Doctor'
                    ? 'Patient: ${appointment.patientName}'
                    : 'Dr. ${appointment.doctorName}',
                style: AppStyle.body1.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 16, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('hh:mm a').format(appointment.appointmentTime),
                    style: AppStyle.body2,
                  ),
                  if (appointment.duration != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      '• ${appointment.duration!.inMinutes} mins',
                      style: AppStyle.body2,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    final color = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: AppStyle.body2.copyWith(color: color),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.check, color: Colors.white),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () => _updateStatus(context, 'confirmed'),
          label: const Text('Accept', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          icon: const Icon(Icons.cancel, color: Colors.white),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => _updateStatus(context, 'cancelled'),
          label: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _updateStatus(BuildContext context, String status) async {
    await context.read<HomePageCubit>().updateStatusAppointment(
          UpdateStatusParams(
            appointmentId: appointment.id,
            status: status,
          ),
        );
    onStatusUpdated();
  }

  bool get _hasNotes =>
      appointment.notes != null && appointment.notes!.isNotEmpty;

  bool get _showActions =>
      userType == 'Doctor' && appointment.status.toLowerCase() == 'pending';
}
