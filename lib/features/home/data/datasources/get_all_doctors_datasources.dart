import 'package:docpoint/features/home/data/models/appointment_model.dart';
import 'package:docpoint/features/home/data/models/doctor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class GetAllDoctorsDatasources {
  Future<List<DoctorModel>> getAllDoctors();
  Future<List<AppointmentModel>> getAllAppointments(
      {required String userType, required String id});
  Future<void> scheduleAppointment({
    required String doctorId,
    required String patientId,
    required DateTime appointmentTime,
    required String status,
    String? notes,
  });
}

class GetAllDoctorsDatasourcesImpl implements GetAllDoctorsDatasources {
  final SupabaseClient _supabaseClient;

  GetAllDoctorsDatasourcesImpl(this._supabaseClient);

  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    try {
      final response = await _supabaseClient.from('doctor_profiles').select('''
      id,
      email,
      first_name,
      last_name,
      phone_number,
      city,
      avatar_url,
      experience,
      category
    ''');

      if (response.isEmpty) {
        throw Exception('No doctors found');
      }

      return response
          .map<DoctorModel>((doctor) => DoctorModel.fromJson(doctor))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch doctors: $e');
    }
  }

  @override
  Future<void> scheduleAppointment({
    required String doctorId,
    required String patientId,
    required DateTime appointmentTime,
    required String status,
    String? notes,
  }) async {
    try {
      final response = await _supabaseClient.from('appointments').insert({
        'doctor_id': doctorId,
        'patient_id': patientId,
        'appointment_time': appointmentTime.toIso8601String(),
        'status': status,
        'notes': notes,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (response != null && response.error != null) {
        throw Exception(response.error!.message);
      }
    } catch (e) {
      throw Exception('Failed to schedule appointment: $e');
    }
  }

  @override
  Future<List<AppointmentModel>> getAllAppointments({
    required String userType,
    required String id,
  }) async {
    try {
      final response = await _supabaseClient
          .from('appointments')
          .select('*')
          .eq(userType == 'Doctor' ? 'doctor_id' : 'patient_id', id);

      List<AppointmentModel> appointments = [];

      for (final appointment in response) {
        final model = AppointmentModel.fromJson(appointment);

        final doctorResponse = await _supabaseClient
            .from('doctor_profiles')
            .select('first_name, last_name, category')
            .eq('id', model.doctorId)
            .maybeSingle();

        final fullName = doctorResponse != null
            ? '${doctorResponse['first_name']} ${doctorResponse['last_name']}'
            : 'Unknown Doctor';
        final category = doctorResponse?['category'] ?? 'General';

        appointments.add(
          model.copyWith(doctorName: fullName, category: category),
        );
      }

      return appointments;
    } catch (e) {
      throw Exception('Failed to fetch appointments: $e');
    }
  }
}
