import 'package:docpoint/core/common/domain/entites/user.dart';
import 'package:docpoint/core/routing/routes.dart';
import 'package:docpoint/features/home/domain/usecase/make_appointment.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_cubit.dart';
import 'package:docpoint/features/home/presentation/logic/home_page_state.dart';
import 'package:docpoint/features/home/presentation/ui/widgets/doctor%20list/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docpoint/core/styles/app_colors.dart';
import 'package:docpoint/core/styles/app_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class MakeAppointmentScreen extends StatefulWidget {
  final User doctor;
  final String patientId;

  const MakeAppointmentScreen({
    super.key,
    required this.doctor,
    required this.patientId,
  });

  @override
  State<MakeAppointmentScreen> createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _notesController = TextEditingController();

  void _pickTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitAppointment() {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please choose date and time")),
      );
      return;
    }

    final DateTime finalDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final appointment = AppointmentParams(
      doctorId: widget.doctor.id,
      patientId: widget.patientId,
      appointmentTime: finalDateTime,
      status: 'pending',
      notes: _notesController.text,
    );

    context.read<HomePageCubit>().scheduleAppointment(appointment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Make Appointment",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          if (state is AppointmentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Appointment Scheduled!")),
            );
            context.go(Routes.homePage);
          } else if (state is AppointmentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                DoctorCard(
                  showButton: false,
                  doctor: widget.doctor,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Choose Date",
                  style: AppStyle.heading2,
                ),
                const SizedBox(height: 10),
                TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: _selectedDate ?? DateTime.now(),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDate, day);
                  },
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: AppColors.primary,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Choose Time",
                  style: AppStyle.heading2,
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.access_time),
                  label: Text(_selectedTime == null
                      ? "Select Time"
                      : _selectedTime!.format(context)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        Colors.white, // 👈 this makes the text/icon color white

                    textStyle: const TextStyle(color: Colors.white),
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Notes (optional)",
                  style: AppStyle.heading2,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: AppStyle.inputDecoration(
                    hintText: "Add any notes...",
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed:
                      state is AppointmentLoading ? null : _submitAppointment,
                  style: AppStyle.primaryButton,
                  child: state is AppointmentLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Book Appointment",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
