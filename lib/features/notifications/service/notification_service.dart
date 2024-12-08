import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;
import '../data/models/notification_model.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  static NotificationService get instance => _instance;

  final List<NotificationModel> _notifications = [];
  late sp.SharedPreferences _prefs;

  NotificationService._();

  Future<void> initialize() async {
    _prefs = await sp.SharedPreferences.getInstance();
  }

  Future<bool> _shouldShowNotification(NotificationType type) async {
    switch (type) {
      case NotificationType.booking:
        return _prefs.getBool('notification_booking') ?? true;
      case NotificationType.payment:
        return _prefs.getBool('notification_payment') ?? true;
      case NotificationType.message:
        return _prefs.getBool('notification_message') ?? true;
      case NotificationType.promotion:
        return _prefs.getBool('notification_promotion') ?? true;
    }
  }

  void _addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    // Limiter à 50 notifications
    if (_notifications.length > 50) {
      _notifications.removeLast();
    }
  }

  List<NotificationModel> getNotifications() {
    return List.unmodifiable(_notifications);
  }

  void clearNotifications() {
    _notifications.clear();
  }

  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  Future<void> showBookingConfirmation(BuildContext context) async {
    if (!await _shouldShowNotification(NotificationType.booking)) return;

    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Réservation confirmée',
      message: 'Le prestataire vous contactera bientôt.',
      type: NotificationType.booking,
      timestamp: DateTime.now(),
    );

    _addNotification(notification);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Réservation confirmée ! Le prestataire vous contactera bientôt.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> showPaymentConfirmation(BuildContext context) async {
    if (!await _shouldShowNotification(NotificationType.payment)) return;

    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Paiement effectué',
      message: 'Votre paiement a été traité avec succès.',
      type: NotificationType.payment,
      timestamp: DateTime.now(),
    );

    _addNotification(notification);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Paiement effectué avec succès !'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> showNewMessage(BuildContext context, String sender) async {
    if (!await _shouldShowNotification(NotificationType.message)) return;

    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Nouveau message',
      message: 'Message de $sender',
      type: NotificationType.message,
      timestamp: DateTime.now(),
      actionRoute: '/chat/$sender',
    );

    _addNotification(notification);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nouveau message de $sender'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Voir',
            textColor: Colors.white,
            onPressed: () {
              // Navigation vers la page de chat
            },
          ),
        ),
      );
    }
  }

  Future<void> showPromotion(BuildContext context, {
    required String title,
    required String message,
    String? actionRoute,
  }) async {
    if (!await _shouldShowNotification(NotificationType.promotion)) return;

    final notification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      message: message,
      type: NotificationType.promotion,
      timestamp: DateTime.now(),
      actionRoute: actionRoute,
    );

    _addNotification(notification);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(message),
            ],
          ),
          backgroundColor: Colors.purple,
          duration: const Duration(seconds: 5),
          action: actionRoute != null
              ? SnackBarAction(
                  label: 'Voir',
                  textColor: Colors.white,
                  onPressed: () {
                    // Navigation
                  },
                )
              : null,
        ),
      );
    }
  }
}
