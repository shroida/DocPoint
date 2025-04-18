import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:docpoint/features/messages/data/model/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class MessagesDatasource {
  Future<void> sendMessage(
      {required String senderId,
      required String receiverId,
      required String messageText,
      required DateTime createdAt,
      required bool isRead,
      String? parentId});
  Future<List<MessageModel>> getMessages();
}

class MessagesDatasourceImpl implements MessagesDatasource {
  final SupabaseClient _supabaseClient;

  MessagesDatasourceImpl(this._supabaseClient);

  @override
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String messageText,
    required DateTime createdAt,
    required bool isRead,
    String? parentId,
  }) async {
    try {
      final messageData = {
        'sender_id': senderId,
        'receiver_id': receiverId,
        'message_text': messageText,
        'created_at': createdAt.toIso8601String(),
        'is_read': isRead,
        if (parentId != null) 'parent_id': int.tryParse(parentId),
      };

      await _supabaseClient.from('messages').insert(messageData);
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<List<MessageModel>> getMessages() async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;

      if (userId == null) {
        throw const ServerExceptions("User is not authenticated.");
      }

      final response = await _supabaseClient
          .from('messages')
          .select()
          .or('sender_id.eq.$userId,receiver_id.eq.$userId') // <-- filter here
          .order('created_at', ascending: true);

      final List<MessageModel> allMessages = (response as List)
          .map((messageJson) => MessageModel.fromJson(messageJson))
          .toList();

      return allMessages;
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }
}
