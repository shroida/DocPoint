import 'package:docpoint/features/home/data/models/doctor_model.dart';
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
      final response =
          await _supabaseClient.from('doctor_profiles').select('*');
      print('Response: $response'); // Log response

      if (response.isEmpty) {
        print('Response: $response'); // Log the response
        throw Exception('No doctors found');
      }
      List<DoctorModel> listDocs = response
          .map<DoctorModel>((doctor) => DoctorModel.fromJson(doctor))
          .toList();
      print('lenght: ${listDocs.length}'); // Log response
      print('Response: ${listDocs.first.firstName}'); // Log response
      return listDocs;
    } catch (e) {
      print('Error fetching doctors: $e'); // Log error

      throw Exception('Failed to fetch doctors: $e');
    }
  }
}
