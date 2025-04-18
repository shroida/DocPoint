import 'package:docpoint/core/error/failure.dart';
import 'package:docpoint/features/messages/domain/entities/message.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MessagesRepo {
  Either<Failure, List<Message>> getAllMessages();
  Either<Failure, void> sendMessage();
}
