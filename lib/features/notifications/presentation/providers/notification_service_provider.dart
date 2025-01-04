import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/notification_service.dart';

class NotificationServiceProvider extends InheritedWidget {
  final NotificationService notificationService;

  NotificationServiceProvider({
    super.key,
    required super.child,
    required this.notificationService,
  });

  static NotificationService of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<NotificationServiceProvider>();
    if (provider == null) {
      throw Exception('NotificationServiceProvider not found in context');
    }
    return provider.notificationService;
  }

  @override
  bool updateShouldNotify(NotificationServiceProvider oldWidget) {
    return notificationService != oldWidget.notificationService;
  }

  static Future<NotificationServiceProvider> create({
    required Widget child,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final service = NotificationService(prefs);
    await service.initialize();
    return NotificationServiceProvider(
      notificationService: service,
      child: child,
    );
  }
}
