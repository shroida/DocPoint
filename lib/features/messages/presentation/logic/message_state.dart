sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}

final class MessageSent extends MessageState {}

final class MessageError extends MessageState {
  final String error;
  MessageError(this.error);
}
