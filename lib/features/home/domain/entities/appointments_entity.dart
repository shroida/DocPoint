class AppointmentEntity {
  final String id;
  final String doctorId;
  final String doctorName;
  final String patientName;
  final String category;
  final String patientId;
  final DateTime appointmentTime;
  final String status;
  final String? notes;
  final int? price;
  final bool? paid;
  final DateTime? createdAt;
  final Duration? duration;

  const AppointmentEntity({
    required this.id,
    required this.doctorId,
    required this.patientName,
    required this.doctorName,
    required this.patientId,
    required this.category,
    required this.appointmentTime,
    this.status = 'pending',
    this.notes,
    this.paid,
    this.price,
    this.createdAt,
    this.duration,
  });
}
