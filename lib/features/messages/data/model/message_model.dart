import 'package:docpoint/features/messages/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel(
      {required super.id,
      required super.senderId,
      required super.receiverId,
      required super.messageText,
      required super.createdAt,
      required super.isRead,
      super.parentId});
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as int,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      messageText: json['message_text'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      isRead: json['is_read'] as bool,
      parentId: json['parent_id'] != null ? json['parent_id'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message_text': messageText,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
      'parent_id': parentId,
    };
  }

  MessageModel copyWith({
    int? id,
    String? senderId,
    String? receiverId,
    String? messageText,
    DateTime? createdAt,
    bool? isRead,
    int? parentId,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      messageText: messageText ?? this.messageText,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      parentId: parentId ?? this.parentId,
    );
  }
}
