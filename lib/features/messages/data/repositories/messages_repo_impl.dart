import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/features/messages/data/datasource/messages_datasource.dart';
import 'package:docpoint/features/messages/domain/entities/message.dart';
import 'package:docpoint/features/messages/domain/repositories/messages_repo.dart';
import 'package:fpdart/fpdart.dart';

class MessagesRepoImpl implements MessagesRepo {
  final MessagesDatasource _messagesDatasource;

  MessagesRepoImpl(this._messagesDatasource);
  @override
  Future<Either<Failure, List<Message>>> getAllMessages() async {
    try {
      final res = await _messagesDatasource.getMessages();
      return Right(res); // Successfully return list of messages
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Wrap any error in Failure
    }
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

  @override
  Future<Either<Failure, void>> makeMessagesRead(
      {required String userId}) async {
    await _messagesDatasource.makeMessagesRead(userId: userId);
    return const Right(null);
  }
}
