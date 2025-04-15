class AppointmentEntity {
  final String id;
  final String doctorId;
  final String patientId;
  final DateTime appointmentTime;
  final String status;
  final String category;
  final String? notes;
  final DateTime? createdAt;
  final Duration? duration;

  const AppointmentEntity({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.category,
    required this.appointmentTime,
    this.status = 'pending',
    this.notes,
    this.createdAt,
    this.duration,
  });
}
