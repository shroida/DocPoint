import 'package:docpoint/features/messages/domain/entities/message.dart';

sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}

final class MessageSent extends MessageState {}

final class MessagesLoaded extends MessageState {
  List<Message> messages;
  MessagesLoaded(this.messages);
}

final class MessageError extends MessageState {
  final String error;
  MessageError(this.error);
}
