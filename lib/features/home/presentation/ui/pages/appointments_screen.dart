import 'package:docpoint/features/home/domain/usecase/update_status_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_cubit.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatefulWidget {
  final String userId;
  final String userType;

  const AppointmentsScreen({
    super.key,
    required this.userId,
    required this.userType,
  });

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  String? _selectedappointmentStatus;
  @override
  void initState() {
    super.initState();

    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    await context.read<HomePageCubit>().getAllAppointments(
          id: widget.userId,
          userType: widget.userType,
        );
  }

  @override
  Widget build(BuildContext context) {
    // final homePageCubit = context.read<HomePageCubit>();

    return Scaffold(
      appBar: widget.userType == "Patient"
          ? AppBar(
              title: const Text(
                'My Appointments',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: AppColors.primary,
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadAppointments,
                ),
              ],
            )
          : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.05),
              AppColors.primary.withOpacity(0.02),
            ],
          ),
        ),
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            if (state is AppointmentLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AppointmentFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, style: AppStyle.heading3),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadAppointments,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is HomePageLoaded) {
              final appointments = state.appointments ?? [];
              final filteredAppointments = _selectedappointmentStatus == null
                  ? appointments
                  : appointments
                      .where((appointment) =>
                          appointment.status == _selectedappointmentStatus)
                      .toList();

              return Column(
                children: [
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    ...appointments.map((appointment) => FilterChip(
                          label:
                              Text(appointment.status, style: AppStyle.body2),
                          selected:
                              _selectedappointmentStatus == appointment.status,
                          onSelected: (selected) {
                            setState(() {
                              _selectedappointmentStatus =
                                  selected ? appointment.status : null;
                            });
                          },
                          selectedColor: AppColors.primaryLight,
                          backgroundColor: AppColors.surface,
                          labelStyle: TextStyle(
                            color:
                                _selectedappointmentStatus == appointment.status
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                          ),
                        )),
                  ]),
                  SizedBox(height: 16.h),
                  Expanded(child: _buildAppointmentList(filteredAppointments)),
                ],
              );
            }

            return const Center(child: Text('No appointments data'));
          },
        ),
      ),
    );
  }

  Widget _buildAppointmentList(List<AppointmentEntity> appointments) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today,
                size: 60, color: AppColors.primary.withOpacity(0.3)),
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
      onRefresh: _loadAppointments,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return _buildAppointmentCard(appointments[index]);
        },
      ),
    );
  }

  Widget _buildAppointmentCard(AppointmentEntity appointment) {
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
            // Header with status and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusChip(appointment.status),
                Text(
                  DateFormat('MMM dd, yyyy')
                      .format(appointment.appointmentTime),
                  style:
                      AppStyle.body2.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Doctor and Time Info
            Row(
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
                        widget.userType == 'Doctor'
                            ? 'Patient: ${appointment.patientName}'
                            : 'Dr. ${appointment.doctorName}',
                        style: AppStyle.body1
                            .copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 16, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('hh:mm a')
                                .format(appointment.appointmentTime),
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
            ),

            // Notes section
            if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
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

            // Doctor action buttons
            if (widget.userType == 'Doctor' &&
                appointment.status.toLowerCase() == 'pending') ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      await context
                          .read<HomePageCubit>()
                          .updateStatusAppointment(
                            UpdateStatusParams(
                              appointmentId: appointment.id,
                              status: 'confirmed',
                            ),
                          );
                      _loadAppointments(); // refresh list after status change
                    },
                    label: const Text(
                      'Accept',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      await context
                          .read<HomePageCubit>()
                          .updateStatusAppointment(
                            UpdateStatusParams(
                              appointmentId: appointment.id,
                              status: 'cancelled',
                            ),
                          );
                      _loadAppointments();
                    },
                    label: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppStyle.caption.copyWith(
          color: _getStatusColor(status),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default: // pending
        return Colors.orange;
    }
  }
}
