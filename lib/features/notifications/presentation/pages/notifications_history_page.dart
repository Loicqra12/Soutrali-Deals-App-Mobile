import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationsHistoryPage extends StatefulWidget {
  const NotificationsHistoryPage({super.key});

  @override
  State<NotificationsHistoryPage> createState() => _NotificationsHistoryPageState();
}

class _NotificationsHistoryPageState extends State<NotificationsHistoryPage> {
  final List<NotificationModel> _notifications = [
    // Exemple de notifications
    NotificationModel(
      id: '1',
      title: 'Réservation confirmée',
      message: 'Votre réservation a été confirmée avec succès',
      type: NotificationType.booking,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      actionRoute: '/booking/123',
    ),
    NotificationModel(
      id: '2',
      title: 'Nouveau message',
      message: 'Vous avez reçu un nouveau message de John',
      type: NotificationType.message,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      actionRoute: '/chat/john',
    ),
    NotificationModel(
      id: '3',
      title: 'Promotion spéciale',
      message: '50% de réduction sur les services de nettoyage',
      type: NotificationType.promotion,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      actionRoute: '/promotions/123',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/notification-settings');
            },
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationTile(notification);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Aucune notification',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile(NotificationModel notification) {
    return Dismissible(
      key: Key(notification.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _notifications.removeWhere((n) => n.id == notification.id);
        });
      },
      child: ListTile(
        leading: _getNotificationIcon(notification.type),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(notification.timestamp),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        onTap: () {
          if (notification.actionRoute != null) {
            context.push(notification.actionRoute!);
          }
        },
      ),
    );
  }

  Widget _getNotificationIcon(NotificationType type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case NotificationType.booking:
        iconData = Icons.calendar_today;
        iconColor = Colors.blue;
        break;
      case NotificationType.payment:
        iconData = Icons.payment;
        iconColor = Colors.green;
        break;
      case NotificationType.message:
        iconData = Icons.message;
        iconColor = Colors.orange;
        break;
      case NotificationType.promotion:
        iconData = Icons.local_offer;
        iconColor = Colors.purple;
        break;
    }

    return CircleAvatar(
      backgroundColor: iconColor.withOpacity(0.1),
      child: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return 'Il y a ${difference.inMinutes} minutes';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours} heures';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(timestamp);
    }
  }
}
