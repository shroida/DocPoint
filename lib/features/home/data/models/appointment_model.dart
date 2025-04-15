import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';

class AppointmentModel extends AppointmentEntity {
  AppointmentModel(
      {required super.id,
      required super.doctorId,
      required super.patientId,
      super.status,
      super.notes,
      super.createdAt,
      required super.category,
      required super.appointmentTime});
  // Factory constructor from JSON
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      doctorId: json['doctor_id'] as String,
      patientId: json['patient_id'] as String,
      category: json['category'] as String,
      appointmentTime: DateTime.parse(json['appointment_time'] as String),
      status: json['status'] as String? ?? 'pending',
      notes: json['notes'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }
}
