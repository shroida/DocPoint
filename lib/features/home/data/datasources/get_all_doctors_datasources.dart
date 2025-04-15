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
    required String patientName,
    required String doctorName,
    required String category,
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
    required String doctorName,
    required String category,
    required String doctorId,
    required String patientId,
    required String patientName,
    required DateTime appointmentTime,
    required String status,
    String? notes,
  }) async {
    try {
      final response = await _supabaseClient.from('appointments').insert({
        'doctor_name': doctorName,
        'patient_id': patientId,
        'doctor_id': doctorId,
        'patient_name': patientName,
        'category': category,
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
      print('[DEBUG] Fetching appointments for $userType with id: $id');

      final response = await _supabaseClient
          .from('appointments')
          .select('*')
          .eq(userType == 'Doctor' ? 'doctor_id' : 'patient_id', id);

      print('[DEBUG] Appointments fetched: ${response.length} items');

      List<AppointmentModel> appointments = [];

      for (final appointment in response) {
        print('[DEBUG] Processing appointment: $appointment');

        final model = AppointmentModel.fromJson(appointment);

        appointments.add(model);
      }

      print('[DEBUG] Total appointments returned: ${appointments.length}');
      return appointments;
    } catch (e) {
      print('[ERROR] Failed to fetch appointments: $e');
      throw Exception('Failed to fetch appointments: $e');
    }
  }
}
