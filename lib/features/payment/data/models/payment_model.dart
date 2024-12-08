import 'package:equatable/equatable.dart';

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
  cancelled,
}

enum PaymentMethod {
  mobileMoney,
  card,
  cash,
}

class PaymentModel extends Equatable {
  final String id;
  final String bookingId;
  final String customerId;
  final String providerId;
  final double amount;
  final PaymentStatus status;
  final PaymentMethod method;
  final String? transactionId;
  final Map<String, dynamic>? paymentDetails;
  final DateTime createdAt;
  final DateTime? completedAt;

  const PaymentModel({
    required this.id,
    required this.bookingId,
    required this.customerId,
    required this.providerId,
    required this.amount,
    this.status = PaymentStatus.pending,
    required this.method,
    this.transactionId,
    this.paymentDetails,
    required this.createdAt,
    this.completedAt,
  });

  PaymentModel copyWith({
    PaymentStatus? status,
    String? transactionId,
    Map<String, dynamic>? paymentDetails,
    DateTime? completedAt,
  }) {
    return PaymentModel(
      id: id,
      bookingId: bookingId,
      customerId: customerId,
      providerId: providerId,
      amount: amount,
      status: status ?? this.status,
      method: method,
      transactionId: transactionId ?? this.transactionId,
      paymentDetails: paymentDetails ?? this.paymentDetails,
      createdAt: createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'customerId': customerId,
      'providerId': providerId,
      'amount': amount,
      'status': status.toString(),
      'method': method.toString(),
      'transactionId': transactionId,
      'paymentDetails': paymentDetails,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      bookingId: json['bookingId'],
      customerId: json['customerId'],
      providerId: json['providerId'],
      amount: json['amount'].toDouble(),
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => PaymentStatus.pending,
      ),
      method: PaymentMethod.values.firstWhere(
        (e) => e.toString() == json['method'],
        orElse: () => PaymentMethod.mobileMoney,
      ),
      transactionId: json['transactionId'],
      paymentDetails: json['paymentDetails'],
      createdAt: DateTime.parse(json['createdAt']),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        bookingId,
        customerId,
        providerId,
        amount,
        status,
        method,
        transactionId,
        paymentDetails,
        createdAt,
        completedAt,
      ];
}
