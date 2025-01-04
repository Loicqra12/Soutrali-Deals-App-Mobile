import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/payment_service.dart';
import '../../../notifications/data/notification_service.dart';
import '../../../notifications/presentation/providers/notification_service_provider.dart';

class PaymentServiceProvider extends InheritedWidget {
  final PaymentService paymentService;

  const PaymentServiceProvider({
    super.key,
    required super.child,
    required this.paymentService,
  });

  static PaymentService of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PaymentServiceProvider>();
    if (provider == null) {
      throw Exception('PaymentServiceProvider not found in context');
    }
    return provider.paymentService;
  }

  @override
  bool updateShouldNotify(PaymentServiceProvider oldWidget) {
    return paymentService != oldWidget.paymentService;
  }

  static Future<PaymentServiceProvider> create({
    required Widget child,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final notificationService = NotificationService(prefs);
    await notificationService.initialize();
    
    return PaymentServiceProvider(
      paymentService: PaymentService(prefs, notificationService),
      child: child,
    );
  }
}
