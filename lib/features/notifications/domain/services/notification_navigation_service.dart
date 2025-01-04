import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/app_notification.dart';
import '../../../payments/data/payment_service.dart';
import '../../../payments/domain/models/payment.dart';

class NotificationNavigationService {
  static Future<void> handleNotificationTap(
    BuildContext context,
    AppNotification notification,
    PaymentService paymentService,
  ) async {
    switch (notification.type) {
      case NotificationType.payment:
        final paymentId = notification.data['paymentId'] as String?;
        if (paymentId != null) {
          // Récupérer les paiements de l'utilisateur
          final payments = await paymentService.getPaymentsByStatus(
            paymentId,
            PaymentStatus.values.firstWhere(
              (status) => status.toString() == notification.data['status'],
              orElse: () => PaymentStatus.pending,
            ),
          );

          if (payments.isNotEmpty) {
            if (context.mounted) {
              context.push(
                '/payment-details',
                extra: {
                  'payment': payments.first,
                },
              );
            }
          }
        }
        break;
      case NotificationType.booking:
        // TODO: Implémenter la navigation vers la réservation
        break;
      case NotificationType.message:
        // TODO: Implémenter la navigation vers la conversation
        break;
      case NotificationType.review:
        // TODO: Implémenter la navigation vers l'avis
        break;
      case NotificationType.general:
        // Pas de navigation spécifique pour les notifications générales
        break;
    }
  }
}
