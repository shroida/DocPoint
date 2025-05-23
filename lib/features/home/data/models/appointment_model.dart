import 'package:docpoint/features/home/domain/entities/appointments_entity.dart';

class AppointmentModel extends AppointmentEntity {
  AppointmentModel(
      {required super.id,
      required super.doctorId,
      required super.doctorName,
      required super.patientName,
      required super.patientId,
      super.status,
      super.notes,
      super.price,
      super.paid,
      super.createdAt,
      required super.category,
      required super.appointmentTime});
  // Factory constructor from JSON
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    try {
      return AppointmentModel(
        id: json['id']?.toString() ?? '',
        doctorId: json['doctor_id']?.toString() ?? '',
        doctorName: json['doctor_name']?.toString() ?? '',
        patientName: json['patient_name']?.toString() ?? '',
        patientId: json['patient_id']?.toString() ?? '',
        category: json['category']?.toString() ?? 'Unknown',
        appointmentTime: DateTime.parse(
            json['appointment_time'] ?? DateTime.now().toIso8601String()),
        status: json['status']?.toString() ?? 'pending',
        notes: json['notes']?.toString(),
        price: json['price'],
        paid: json['paid'],
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'].toString())
            : null,
      );
    } catch (e) {
      throw Exception('Failed to parse AppointmentModel: $e');
    }
  }

  AppointmentModel copyWith({
    String? doctorName,
    String? category,
  }) {
    return AppointmentModel(
      id: id,
      doctorId: doctorId,
      patientId: patientId,
      patientName: patientName,
      appointmentTime: appointmentTime,
      status: status,
      notes: notes,
      price: price,
      createdAt: createdAt,
      category: category ?? this.category,
      doctorName: doctorName ?? this.doctorName,
    );
  }
}
