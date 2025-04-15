import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UpdateStatusUsecase implements UseCase<void, String> {
  @override
  Future<Either<Failure, void>> call(String id) {}
}
