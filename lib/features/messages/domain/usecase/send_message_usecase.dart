import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/messages/domain/repositories/messages_repo.dart';
import 'package:fpdart/fpdart.dart';

class SendMessageUsecase implements UseCase<void, SendMessageParams> {
  final MessagesRepo _messagesRepo;

  SendMessageUsecase(this._messagesRepo);
  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    return await _messagesRepo.sendMessage(
        senderId: params.senderId,
        receiverId: params.receiverId,
        messageText: params.messageText,
        createdAt: params.createdAt,
        isRead: params.isRead,
        parentId: params.parentId);
  }
}

class SendMessageParams {
  final String senderId;
  final String receiverId;
  final String messageText;
  final DateTime createdAt;
  final bool isRead;
  final String parentId;

  SendMessageParams(
      {required this.senderId,
      required this.receiverId,
      required this.messageText,
      required this.createdAt,
      required this.isRead,
      required this.parentId});
}
