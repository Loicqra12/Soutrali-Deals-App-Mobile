import 'dart:async';
import '../domain/models/message.dart';
import '../domain/models/conversation.dart';
import 'package:shared_preferences.dart';
import 'dart:convert';

class MessagingService {
  static const String _messagesKey = 'messages';
  static const String _conversationsKey = 'conversations';
  final SharedPreferences _prefs;
  final StreamController<Message> _messageController = StreamController<Message>.broadcast();
  final StreamController<List<Conversation>> _conversationsController = StreamController<List<Conversation>>.broadcast();

  MessagingService(this._prefs);

  Stream<Message> get messageStream => _messageController.stream;
  Stream<List<Conversation>> get conversationsStream => _conversationsController.stream;

  Future<List<Message>> getMessages(String conversationId) async {
    final String? messagesJson = _prefs.getString('$_messagesKey:$conversationId');
    if (messagesJson == null) return [];

    final List<dynamic> messagesList = json.decode(messagesJson);
    return messagesList.map((json) => Message(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'],
      type: MessageType.values.firstWhere((e) => e.toString() == json['type']),
      attachmentUrl: json['attachmentUrl'],
    )).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<List<Conversation>> getConversations(String userId) async {
    final String? conversationsJson = _prefs.getString(_conversationsKey);
    if (conversationsJson == null) return [];

    final List<dynamic> conversationsList = json.decode(conversationsJson);
    return conversationsList
        .map((json) => Conversation(
              id: json['id'],
              freelancerId: json['freelancerId'],
              clientId: json['clientId'],
              lastMessageTime: DateTime.parse(json['lastMessageTime']),
              lastMessageContent: json['lastMessageContent'],
              hasUnreadMessages: json['hasUnreadMessages'],
              status: ConversationStatus.values
                  .firstWhere((e) => e.toString() == json['status']),
            ))
        .where((conversation) =>
            conversation.freelancerId == userId || conversation.clientId == userId)
        .toList()
      ..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
  }

  Future<void> sendMessage(Message message) async {
    // Sauvegarder le message
    final messages = await getMessages(
        '${message.senderId}_${message.receiverId}');
    messages.insert(0, message);

    final List<Map<String, dynamic>> messagesJson = messages
        .map((message) => {
              'id': message.id,
              'senderId': message.senderId,
              'receiverId': message.receiverId,
              'content': message.content,
              'timestamp': message.timestamp.toIso8601String(),
              'isRead': message.isRead,
              'type': message.type.toString(),
              'attachmentUrl': message.attachmentUrl,
            })
        .toList();

    await _prefs.setString(
        '$_messagesKey:${message.senderId}_${message.receiverId}',
        json.encode(messagesJson));

    // Mettre à jour la conversation
    final conversations = await getConversations(message.senderId);
    final conversationIndex = conversations.indexWhere(
      (c) =>
          (c.freelancerId == message.senderId &&
              c.clientId == message.receiverId) ||
          (c.freelancerId == message.receiverId &&
              c.clientId == message.senderId),
    );

    if (conversationIndex >= 0) {
      conversations[conversationIndex] = Conversation(
        id: conversations[conversationIndex].id,
        freelancerId: conversations[conversationIndex].freelancerId,
        clientId: conversations[conversationIndex].clientId,
        lastMessageTime: message.timestamp,
        lastMessageContent: message.content,
        hasUnreadMessages: true,
        status: conversations[conversationIndex].status,
      );
    } else {
      conversations.add(Conversation.create(
        freelancerId: message.senderId,
        clientId: message.receiverId,
        initialMessage: message.content,
      ));
    }

    final List<Map<String, dynamic>> conversationsJson = conversations
        .map((conversation) => {
              'id': conversation.id,
              'freelancerId': conversation.freelancerId,
              'clientId': conversation.clientId,
              'lastMessageTime': conversation.lastMessageTime.toIso8601String(),
              'lastMessageContent': conversation.lastMessageContent,
              'hasUnreadMessages': conversation.hasUnreadMessages,
              'status': conversation.status.toString(),
            })
        .toList();

    await _prefs.setString(_conversationsKey, json.encode(conversationsJson));

    // Notifier les écouteurs
    _messageController.add(message);
    _conversationsController.add(conversations);
  }

  Future<void> markAsRead(String conversationId, String userId) async {
    final messages = await getMessages(conversationId);
    final updatedMessages = messages.map((message) {
      if (message.receiverId == userId && !message.isRead) {
        return Message(
          id: message.id,
          senderId: message.senderId,
          receiverId: message.receiverId,
          content: message.content,
          timestamp: message.timestamp,
          isRead: true,
          type: message.type,
          attachmentUrl: message.attachmentUrl,
        );
      }
      return message;
    }).toList();

    final List<Map<String, dynamic>> messagesJson = updatedMessages
        .map((message) => {
              'id': message.id,
              'senderId': message.senderId,
              'receiverId': message.receiverId,
              'content': message.content,
              'timestamp': message.timestamp.toIso8601String(),
              'isRead': message.isRead,
              'type': message.type.toString(),
              'attachmentUrl': message.attachmentUrl,
            })
        .toList();

    await _prefs.setString(
        '$_messagesKey:$conversationId', json.encode(messagesJson));

    // Mettre à jour le statut de la conversation
    final conversations = await getConversations(userId);
    final conversationIndex =
        conversations.indexWhere((c) => c.id == conversationId);

    if (conversationIndex >= 0) {
      conversations[conversationIndex] = Conversation(
        id: conversations[conversationIndex].id,
        freelancerId: conversations[conversationIndex].freelancerId,
        clientId: conversations[conversationIndex].clientId,
        lastMessageTime: conversations[conversationIndex].lastMessageTime,
        lastMessageContent: conversations[conversationIndex].lastMessageContent,
        hasUnreadMessages: false,
        status: conversations[conversationIndex].status,
      );

      final List<Map<String, dynamic>> conversationsJson = conversations
          .map((conversation) => {
                'id': conversation.id,
                'freelancerId': conversation.freelancerId,
                'clientId': conversation.clientId,
                'lastMessageTime':
                    conversation.lastMessageTime.toIso8601String(),
                'lastMessageContent': conversation.lastMessageContent,
                'hasUnreadMessages': conversation.hasUnreadMessages,
                'status': conversation.status.toString(),
              })
          .toList();

      await _prefs.setString(_conversationsKey, json.encode(conversationsJson));
      _conversationsController.add(conversations);
    }
  }

  void dispose() {
    _messageController.close();
    _conversationsController.close();
  }
}
