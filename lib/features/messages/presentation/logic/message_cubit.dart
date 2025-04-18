import 'package:bloc/bloc.dart';
import 'package:docpoint/features/messages/presentation/logic/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());
}
