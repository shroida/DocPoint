import 'package:docpoint/features/home/data/models/doctor_model.dart';

abstract interface class GetAllDoctorsDatasources {
  Future<List<DoctorModel>> getAllDoctorts();
}

class GetAllDoctorsDatasourcesImpl implements GetAllDoctorsDatasources {
  @override
  Future<List<DoctorModel>> getAllDoctorts() {}
}
