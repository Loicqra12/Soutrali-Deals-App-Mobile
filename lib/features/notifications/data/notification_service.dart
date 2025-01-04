import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/app_notification.dart';

class NotificationService {
  static const String _notificationsKey = 'notifications';
  
  final SharedPreferences _prefs;
  final StreamController<List<AppNotification>> _notificationsController = 
      StreamController<List<AppNotification>>.broadcast();

  NotificationService(this._prefs);

  Stream<List<AppNotification>> get notificationsStream => _notificationsController.stream;

  Future<void> initialize() async {
    _notifyListeners();
  }

  Future<List<AppNotification>> getNotifications() async {
    final String? notificationsJson = _prefs.getString(_notificationsKey);
    if (notificationsJson == null) return [];

    final List<dynamic> notificationsList = json.decode(notificationsJson);
    return notificationsList
        .map((json) => AppNotification.fromJson(json))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> addNotification({
    required String title,
    required String body,
    required NotificationType type,
    Map<String, dynamic> data = const {},
  }) async {
    final notification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      type: type,
      data: data,
      timestamp: DateTime.now(),
      isRead: false,
    );

    final notifications = await getNotifications();
    notifications.insert(0, notification);
    await _saveNotifications(notifications);
    _notifyListeners();
  }

  Future<void> markAsRead(String notificationId) async {
    final notifications = await getNotifications();
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index >= 0) {
      notifications[index] = notifications[index].copyWith(isRead: true);
      await _saveNotifications(notifications);
      _notifyListeners();
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    final notifications = await getNotifications();
    notifications.removeWhere((n) => n.id == notificationId);
    await _saveNotifications(notifications);
    _notifyListeners();
  }

  Future<void> _saveNotifications(List<AppNotification> notifications) async {
    final List<Map<String, dynamic>> notificationsJson =
        notifications.map((n) => n.toJson()).toList();
    await _prefs.setString(_notificationsKey, json.encode(notificationsJson));
  }

  void _notifyListeners() async {
    final notifications = await getNotifications();
    _notificationsController.add(notifications);
  }

  void dispose() {
    _notificationsController.close();
  }
}
