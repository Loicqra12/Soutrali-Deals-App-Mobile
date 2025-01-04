class Conversation {
  final String id;
  final String freelancerId;
  final String clientId;
  final DateTime lastMessageTime;
  final String lastMessageContent;
  final bool hasUnreadMessages;
  final ConversationStatus status;

  const Conversation({
    required this.id,
    required this.freelancerId,
    required this.clientId,
    required this.lastMessageTime,
    required this.lastMessageContent,
    required this.hasUnreadMessages,
    required this.status,
  });

  factory Conversation.create({
    required String freelancerId,
    required String clientId,
    required String initialMessage,
  }) {
    return Conversation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      freelancerId: freelancerId,
      clientId: clientId,
      lastMessageTime: DateTime.now(),
      lastMessageContent: initialMessage,
      hasUnreadMessages: true,
      status: ConversationStatus.active,
    );
  }
}

enum ConversationStatus {
  active,
  archived,
  blocked,
}
