import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:docpoint/features/home/data/models/doctor_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class GetAllDoctorsDatasources {
  Future<List<DoctorModel>> getAllDoctors();
}

class GetAllDoctorsDatasourcesImpl implements GetAllDoctorsDatasources {
  final SupabaseClient _supabaseClient;

  GetAllDoctorsDatasourcesImpl(this._supabaseClient);

  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    try {
      debugPrint('[Datasource] Fetching doctors from Supabase...');
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

      debugPrint('[Datasource] Supabase response: $response');

      if (response.isEmpty) {
        throw Exception('No doctors found');
      }

      return response
          .map<DoctorModel>((doctor) => DoctorModel.fromJson(doctor))
          .toList();
    } catch (e) {
      debugPrint('[Datasource] Error: $e');
      throw Exception('Failed to fetch doctors: $e');
    }
  }
}
