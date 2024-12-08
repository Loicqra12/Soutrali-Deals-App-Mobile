import 'package:equatable/equatable.dart';
import '../../data/models/payment_model.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentInitiated extends PaymentState {
  final PaymentModel payment;

  const PaymentInitiated(this.payment);

  @override
  List<Object> get props => [payment];
}

class PaymentConfirmed extends PaymentState {
  final PaymentModel payment;

  const PaymentConfirmed(this.payment);

  @override
  List<Object> get props => [payment];
}

class PaymentRefunded extends PaymentState {
  final String paymentId;
  final String? reason;

  const PaymentRefunded({
    required this.paymentId,
    this.reason,
  });

  @override
  List<Object?> get props => [paymentId, reason];
}

class PaymentsLoaded extends PaymentState {
  final List<PaymentModel> payments;

  const PaymentsLoaded(this.payments);

  @override
  List<Object> get props => [payments];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError(this.message);

  @override
  List<Object> get props => [message];
}
