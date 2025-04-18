import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/messages/domain/entities/message.dart';
import 'package:docpoint/features/messages/domain/repositories/messages_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetAllMessagesUsecase implements UseCase<List<Message>, NoParams> {
  final MessagesRepo _messagesRepo;

  GetAllMessagesUsecase(this._messagesRepo);

  @override
  Future<Either<Failure, List<Message>>> call(NoParams params) async {
    final res = await _messagesRepo.getAllMessages();
    return res.fold(
      (failure) => Left(ServerFailure(failure.message)),
      (list) => Right(list),
    );
  }
}
