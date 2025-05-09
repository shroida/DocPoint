import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/features/messages/domain/entities/message.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MessagesRepo {
  Future<Either<Failure, List<Message>>> getAllMessages();
  Future<Either<Failure, void>> makeMessagesRead({required String userId});
  Future<Either<Failure, void>> sendMessage(
      {required String senderId,
      required String receiverId,
      required String messageText,
      required DateTime createdAt,
      required bool isRead,
      String? parentId});
}
