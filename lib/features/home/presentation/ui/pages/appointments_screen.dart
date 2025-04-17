// appointments_screen.dart
import 'package:docpoint/features/home/presentation/ui/widgets/appointment%20list/appointments_list.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/doctor%20list/filter_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_cubit.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/appointment_card.dart';
import '../widgets/appointments_list.dart';
import '../widgets/empty_appointments.dart';

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
  String? _selectedStatus;

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
              title: const Text('My Appointments',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true,
              elevation: 0,
              backgroundColor: AppColors.primary,
              actions: [
                IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _loadAppointments),
              ],
            )
          : null,
      body: BlocBuilder<HomePageCubit, HomePageState>(
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

            final filtered = _selectedStatus == null
                ? appointments
                : appointments
                    .where((e) => e.status == _selectedStatus)
                    .toList();

            return Column(
              children: [
                const SizedBox(height: 12),
                if (appointments.isNotEmpty)
                  FilterChipsRow(
                    list: appointments.map((e) => e.status).toSet().toList(),
                    selectedlist: _selectedStatus,
                    onSelected: (val) => setState(() => _selectedStatus = val),
                  ),
                SizedBox(height: 16.h),
                Expanded(
                  child: filtered.isEmpty
                      ? const EmptyAppointmentsWidget()
                      : AppointmentsList(
                          appointments: filtered,
                          userType: widget.userType,
                          onRefresh: _loadAppointments,
                        ),
                ),
              ],
            );
          }

          return const Center(child: Text('No appointments data'));
        },
      ),
    );
  }
}
