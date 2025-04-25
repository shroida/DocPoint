import 'package:docpoint/features/home/data/models/doctor_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract interface class LocalGetAllDoctorsDatasource {
  List<DoctorModel> getAllDoctors();
  void uploadLocalDoctors({required List<DoctorModel> doctors});
}

class LocalGetAllDoctorsDatasourceImpL implements LocalGetAllDoctorsDatasource {
  final Box box;
  LocalGetAllDoctorsDatasourceImpL(this.box);
  @override
  List<DoctorModel> getAllDoctors() {
    List<DoctorModel> doctors = [];
    for (int i = 0; i < box.length; i++) {
      final doctorsJson = box.get(i.toString());
      if (doctorsJson != null) {
        doctors
            .add(DoctorModel.fromJson(Map<String, dynamic>.from(doctorsJson)));
      }
    }
    return doctors;
  }

  @override
  void uploadLocalDoctors({required List<DoctorModel> doctors}) {
    box.clear();

    for (int i = 0; i < doctors.length; i++) {
      box.put(i.toString(), doctors[i].toJson());
    }
  }
}
