import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../domain/models/payment.dart';
import '../domain/models/payment_method.dart';

class CinetPayService {
  static const String _apiUrl = 'https://api-checkout.cinetpay.com/v2/payment';
  static const String _baseUrl = 'https://checkout.cinetpay.com/';
  
  // TODO: Remplacer par vos clés CinetPay réelles
  static const String apiKey = 'YOUR_API_KEY';
  static const String siteId = 'YOUR_SITE_ID';

  final http.Client _client;
  final Random _random = Random();

  CinetPayService({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> initializePayment({
    required String transactionId,
    required double amount,
    required String currency,
    required String description,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required String notifyUrl,
    required String returnUrl,
    required String cancelUrl,
    required PaymentMethod paymentMethod,
  }) async {
    final data = {
      'apikey': apiKey,
      'site_id': siteId,
      'transaction_id': transactionId,
      'amount': amount,
      'currency': currency,
      'description': description,
      'customer_name': customerName,
      'customer_email': customerEmail,
      'customer_phone_number': customerPhone,
      'notify_url': notifyUrl,
      'return_url': returnUrl,
      'cancel_url': cancelUrl,
      'channels': paymentMethod.channel,
      'lang': 'fr',
      'metadata': 'payment_app',
    };

    try {
      final response = await _client.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['code'] == '201') {
          return {
            'success': true,
            'payment_url': responseData['data']['payment_url'],
            'payment_token': responseData['data']['payment_token'],
          };
        } else {
          return {
            'success': false,
            'error': responseData['message'],
          };
        }
      } else {
        return {
          'success': false,
          'error': 'Erreur de communication avec CinetPay',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Erreur: $e',
      };
    }
  }

  Future<Map<String, dynamic>> checkPaymentStatus({
    required String transactionId,
    required String siteId,
  }) async {
    final data = {
      'apikey': apiKey,
      'site_id': siteId,
      'transaction_id': transactionId,
    };

    try {
      final response = await _client.post(
        Uri.parse('${_apiUrl}/check'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return {
          'success': true,
          'status': responseData['data']['status'],
          'amount': responseData['data']['amount'],
          'currency': responseData['data']['currency'],
          'payment_method': responseData['data']['payment_method'],
          'operator_id': responseData['data']['operator_id'],
        };
      } else {
        return {
          'success': false,
          'error': 'Erreur lors de la vérification du paiement',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Erreur: $e',
      };
    }
  }

  String generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomNum = _random.nextInt(999999).toString().padLeft(6, '0');
    return 'TRANS_${timestamp}_$randomNum';
  }

  PaymentStatus mapCinetPayStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'successful':
        return PaymentStatus.completed;
      case 'failed':
      case 'error':
        return PaymentStatus.failed;
      case 'refunded':
        return PaymentStatus.refunded;
      default:
        return PaymentStatus.pending;
    }
  }

  void dispose() {
    _client.close();
  }
}
