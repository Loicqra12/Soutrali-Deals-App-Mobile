enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded
}

class Payment {
  final String id;
  final String clientId;
  final String freelancerId;
  final double amount;
  final DateTime date;
  final PaymentStatus status;
  final String? transactionId;
  final String description;

  const Payment({
    required this.id,
    required this.clientId,
    required this.freelancerId,
    required this.amount,
    required this.date,
    required this.status,
    this.transactionId,
    required this.description,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      freelancerId: json['freelancerId'] as String,
      amount: json['amount'] as double,
      date: DateTime.parse(json['date'] as String),
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString() == 'PaymentStatus.${json['status']}',
      ),
      transactionId: json['transactionId'] as String?,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'freelancerId': freelancerId,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status.toString().split('.').last,
      'transactionId': transactionId,
      'description': description,
    };
  }
}
