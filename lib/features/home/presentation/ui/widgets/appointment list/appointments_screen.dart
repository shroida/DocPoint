import 'package:docpoint/core/common/logic/cubit/currentuser_cubit.dart';
import 'package:docpoint/features/home/domain/usecase/update_status_usecase.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/appointment%20list/appointment_card.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/doctor%20list/filter_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_cubit.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              final List<String> appointmentStatuses = appointments
                  .map((e) => e.status)
                  .toSet()
                  .toList(); // ensure uniqueness

              return Column(
                children: [
                  const SizedBox(height: 12),
                  if (appointments.isNotEmpty)
                    FilterChipsRow(
                      list: appointmentStatuses,
                      selectedlist: _selectedappointmentStatus,
                      onSelected: (status) {
                        setState(() {
                          _selectedappointmentStatus = status;
                        });
                      },
                    ),
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
          return DetailedAppointmentCard(
            appointment: appointments[index],
            onStatusUpdated: () async {
              await context.read<HomePageCubit>().updateStatusAppointment(
                    UpdateStatusParams(
                      appointmentId: appointments[index].id,
                      status: 'confirmed',
                    ),
                  );
              _loadAppointments(); // refresh list after status change
            },
            userType: context.read<CurrentUserCubit>().userType,
          );
        },
      ),
    );
  }
}
