class Message {
  final int id;
  final String senderId;
  final String receiverId;
  final String messageText;
  final DateTime createdAt;
  final bool isRead;
  final int? parentId;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.messageText,
    required this.createdAt,
    required this.isRead,
    this.parentId,
  });
}
