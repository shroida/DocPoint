import 'package:bloc/bloc.dart';
import 'package:docpoint/features/messages/domain/usecase/send_message_usecase.dart';
import 'package:docpoint/features/messages/presentation/logic/message_state.dart';
import 'package:docpoint/core/error/failure.dart';

class MessageCubit extends Cubit<MessageState> {
  final SendMessageUsecase _sendMessageUsecase;

  MessageCubit(this._sendMessageUsecase) : super(MessageInitial());

  Future<void> sendMessage(SendMessageParams params) async {
    emit(MessageLoading());
    final result = await _sendMessageUsecase(params);
    result.fold(
      (Failure failure) => emit(MessageError(failure.message)),
      (_) => emit(MessageSent()),
    );
  }
}
