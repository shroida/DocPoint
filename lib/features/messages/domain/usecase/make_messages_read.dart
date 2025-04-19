import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/messages/domain/repositories/messages_repo.dart';
import 'package:fpdart/fpdart.dart';

class MakeMessagesRead implements UseCase<void, String> {
  final MessagesRepo _messagesRepo;

  MakeMessagesRead(this._messagesRepo);
  @override
  Future<Either<Failure, void>> call(String appointmentId) async {}
}
