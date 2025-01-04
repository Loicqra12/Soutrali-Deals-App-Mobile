import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/payment.dart';
import '../../notifications/data/notification_service.dart';
import '../../notifications/domain/models/app_notification.dart';
import '../domain/models/payment_method.dart';
import 'cinetpay_service.dart';

class PaymentService {
  static const String _paymentsKey = 'payments';
  final SharedPreferences _prefs;
  final NotificationService _notificationService;
  final CinetPayService _cinetPayService;
  final StreamController<List<Payment>> _paymentsController = StreamController<List<Payment>>.broadcast();

  PaymentService(this._prefs, this._notificationService)
      : _cinetPayService = CinetPayService();

  Stream<List<Payment>> get paymentsStream => _paymentsController.stream;

  Future<List<Payment>> _getAllPayments() async {
    final paymentsJson = _prefs.getStringList(_paymentsKey) ?? [];
    return paymentsJson
        .map((json) => Payment.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> _savePayments(List<Payment> payments) async {
    final paymentsJson = payments
        .map((payment) => jsonEncode(payment.toJson()))
        .toList();
    await _prefs.setStringList(_paymentsKey, paymentsJson);
    _paymentsController.add(payments);
  }

  Future<Payment> createPayment({
    required String clientId,
    required String freelancerId,
    required double amount,
    required String description,
  }) async {
    final payments = await _getAllPayments();
    
    final payment = Payment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      clientId: clientId,
      freelancerId: freelancerId,
      amount: amount,
      date: DateTime.now(),
      status: PaymentStatus.pending,
      description: description,
    );

    payments.add(payment);
    await _savePayments(payments);

    // Envoyer une notification au client
    await _notificationService.addNotification(
      title: 'Nouveau paiement',
      body: 'Paiement de ${payment.amount} FCFA initié',
      type: NotificationType.payment,
      data: {
        'paymentId': payment.id,
        'status': payment.status.toString(),
      },
    );

    return payment;
  }

  Future<void> updatePaymentStatus(
    String paymentId,
    PaymentStatus status, {
    String? transactionId,
  }) async {
    final payments = await _getAllPayments();
    final index = payments.indexWhere((p) => p.id == paymentId);

    if (index != -1) {
      final payment = payments[index];
      payments[index] = Payment(
        id: payment.id,
        clientId: payment.clientId,
        freelancerId: payment.freelancerId,
        amount: payment.amount,
        date: payment.date,
        status: status,
        transactionId: transactionId ?? payment.transactionId,
        description: payment.description,
      );

      await _savePayments(payments);

      // Envoyer une notification au client
      String notificationBody;
      switch (status) {
        case PaymentStatus.completed:
          notificationBody = 'Paiement de ${payment.amount} FCFA effectué avec succès';
          break;
        case PaymentStatus.failed:
          notificationBody = 'Échec du paiement de ${payment.amount} FCFA';
          break;
        case PaymentStatus.refunded:
          notificationBody = 'Paiement de ${payment.amount} FCFA remboursé';
          break;
        default:
          notificationBody = 'Statut du paiement mis à jour';
      }

      await _notificationService.addNotification(
        title: 'Statut du paiement',
        body: notificationBody,
        type: NotificationType.payment,
        data: {
          'paymentId': payment.id,
          'status': status.toString(),
        },
      );
    }
  }

  Future<Map<String, dynamic>> initializePayment({
    required String clientId,
    required String freelancerId,
    required double amount,
    required String description,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required PaymentMethod paymentMethod,
  }) async {
    final payment = await createPayment(
      clientId: clientId,
      freelancerId: freelancerId,
      amount: amount,
      description: description,
    );

    final transactionId = _cinetPayService.generateTransactionId();
    final result = await _cinetPayService.initializePayment(
      transactionId: transactionId,
      amount: amount,
      currency: 'XOF', // Franc CFA
      description: description,
      customerName: customerName,
      customerEmail: customerEmail,
      customerPhone: customerPhone,
      notifyUrl: 'https://votre-domaine.com/notify',
      returnUrl: 'https://votre-domaine.com/return',
      cancelUrl: 'https://votre-domaine.com/cancel',
      paymentMethod: paymentMethod,
    );

    if (result['success']) {
      return {
        'success': true,
        'payment_url': result['payment_url'],
        'payment_id': payment.id,
      };
    } else {
      await updatePaymentStatus(payment.id, PaymentStatus.failed);
      return {
        'success': false,
        'error': result['error'],
      };
    }
  }

  Future<void> processPayment(String paymentId) async {
    try {
      final payments = await _getAllPayments();
      final payment = payments.firstWhere((p) => p.id == paymentId);
      
      final result = await _cinetPayService.checkPaymentStatus(
        transactionId: payment.transactionId ?? '',
        siteId: CinetPayService.siteId,
      );

      if (result['success']) {
        final status = _cinetPayService.mapCinetPayStatus(result['status']);
        await updatePaymentStatus(
          paymentId,
          status,
          transactionId: result['operator_id'],
        );
      } else {
        await updatePaymentStatus(paymentId, PaymentStatus.failed);
      }
    } catch (e) {
      await updatePaymentStatus(paymentId, PaymentStatus.failed);
      rethrow;
    }
  }

  Future<List<Payment>> getPaymentsByStatus(String userId, PaymentStatus status) async {
    final payments = await _getAllPayments();
    return payments
        .where((p) => 
            (p.clientId == userId || p.freelancerId == userId) &&
            p.status == status)
        .toList();
  }

  void dispose() {
    _paymentsController.close();
    _cinetPayService.dispose();
  }
}
