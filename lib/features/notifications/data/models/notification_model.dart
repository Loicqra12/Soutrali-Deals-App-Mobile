import 'package:equatable/equatable.dart';

enum NotificationType {
  booking,
  payment,
  message,
  promotion,
}

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final String? actionRoute;
  final Map<String, dynamic>? actionParams;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.actionRoute,
    this.actionParams,
  });

  NotificationModel copyWith({
    String? title,
    String? message,
    NotificationType? type,
    DateTime? timestamp,
    bool? isRead,
    String? actionRoute,
    Map<String, dynamic>? actionParams,
  }) {
    return NotificationModel(
      id: id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      actionRoute: actionRoute ?? this.actionRoute,
      actionParams: actionParams ?? this.actionParams,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type.toString(),
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'actionRoute': actionRoute,
      'actionParams': actionParams,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      type: NotificationType.values.firstWhere(
        (e) => e.toString() == json['type'],
      ),
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
      actionRoute: json['actionRoute'],
      actionParams: json['actionParams'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        message,
        type,
        timestamp,
        isRead,
        actionRoute,
        actionParams,
      ];
}
