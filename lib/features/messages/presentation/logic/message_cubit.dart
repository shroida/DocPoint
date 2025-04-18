import 'package:bloc/bloc.dart';
import 'package:docpoint/core/usecase/usecase.dart';
import 'package:docpoint/features/messages/domain/entities/message.dart';
import 'package:docpoint/features/messages/domain/usecase/get_all_messages_usecase.dart';
import 'package:docpoint/features/messages/domain/usecase/send_message_usecase.dart';
import 'package:docpoint/features/messages/presentation/logic/message_state.dart';
import 'package:docpoint/core/error/failure.dart';

class MessageCubit extends Cubit<MessageState> {
  final SendMessageUsecase _sendMessageUsecase;
  final GetAllMessagesUsecase _getAllMessagesUsecase;

  MessageCubit(this._sendMessageUsecase, this._getAllMessagesUsecase)
      : super(MessageInitial());

  List<Message> allMessages = [];

  Future<void> sendMessage(SendMessageParams params) async {
    emit(MessageLoading());
    final result = await _sendMessageUsecase(params);
    result.fold(
      (Failure failure) => emit(MessageError(failure.message)),
      (_) => emit(MessageSent()),
    );
  }

  Future<void> getAllMessages() async {
    emit(MessageLoading());
    final result = await _getAllMessagesUsecase(NoParams());
    result.fold(
      (Failure failure) => emit(MessageError(failure.message)),
      (List<Message> messages) {
        allMessages = messages;
        emit(MessagesLoaded(messages));
      },
    );
  }
}
