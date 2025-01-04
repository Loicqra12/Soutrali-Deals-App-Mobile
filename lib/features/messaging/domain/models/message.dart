class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final MessageType type;
  final String? attachmentUrl;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    required this.isRead,
    required this.type,
    this.attachmentUrl,
  });

  factory Message.create({
    required String senderId,
    required String receiverId,
    required String content,
    MessageType type = MessageType.text,
    String? attachmentUrl,
  }) {
    return Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      timestamp: DateTime.now(),
      isRead: false,
      type: type,
      attachmentUrl: attachmentUrl,
    );
  }
}

enum MessageType {
  text,
  image,
  file,
  location,
}
