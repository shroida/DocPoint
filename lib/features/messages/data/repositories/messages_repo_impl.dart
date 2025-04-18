import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/features/messages/data/datasource/messages_datasource.dart';
import 'package:docpoint/features/messages/domain/entities/message.dart';
import 'package:docpoint/features/messages/domain/repositories/messages_repo.dart';
import 'package:fpdart/fpdart.dart';

class MessagesRepoImpl implements MessagesRepo {
  final MessagesDatasource _messagesDatasource;

  MessagesRepoImpl(this._messagesDatasource);
  @override
  Either<Failure, List<Message>> getAllMessages() {
    
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      {required String senderId,
      required String receiverId,
      required String messageText,
      required DateTime createdAt,
      required bool isRead,
      String? parentId}) async {
    await _messagesDatasource.sendMessage(
        senderId: senderId,
        receiverId: receiverId,
        messageText: messageText,
        createdAt: createdAt,
        isRead: isRead);
    return const Right(null);
  }
}
