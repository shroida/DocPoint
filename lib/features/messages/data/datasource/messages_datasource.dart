import 'package:docpoint/core/error/server_exeptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class MessagesDatasource {
  Future<void> sendMessage(
      {required String senderId,
      required String receiverId,
      required String messageText,
      required DateTime createdAt,
      required bool isRead,
      String? parentId});
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
}
