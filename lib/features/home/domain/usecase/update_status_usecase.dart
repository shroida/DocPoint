import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UpdateStatusUsecase implements UseCase<void, UpdateStatusParams> {
  @override
  Future<Either<Failure, void>> call(UpdateStatusParams params) {
    
  }
}

class UpdateStatusParams {
  final String appointmentId;
  final String status;

  UpdateStatusParams({required this.appointmentId, required this.status});
}
