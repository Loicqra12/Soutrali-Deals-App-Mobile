import 'package:equatable/equatable.dart';
import '../../data/models/payment_model.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class PaymentInitiateRequested extends PaymentEvent {
  final String bookingId;
  final double amount;
  final PaymentMethod method;
  final Map<String, dynamic>? metadata;

  const PaymentInitiateRequested({
    required this.bookingId,
    required this.amount,
    required this.method,
    this.metadata,
  });

  @override
  List<Object?> get props => [bookingId, amount, method, metadata];
}

class PaymentConfirmRequested extends PaymentEvent {
  final String paymentId;

  const PaymentConfirmRequested(this.paymentId);

  @override
  List<Object> get props => [paymentId];
}

class PaymentRefundRequested extends PaymentEvent {
  final String paymentId;
  final String? reason;

  const PaymentRefundRequested({
    required this.paymentId,
    this.reason,
  });

  @override
  List<Object?> get props => [paymentId, reason];
}

class CustomerPaymentsFetchRequested extends PaymentEvent {
  final String customerId;

  const CustomerPaymentsFetchRequested(this.customerId);

  @override
  List<Object> get props => [customerId];
}

class ProviderPaymentsFetchRequested extends PaymentEvent {
  final String providerId;

  const ProviderPaymentsFetchRequested(this.providerId);

  @override
  List<Object> get props => [providerId];
}
