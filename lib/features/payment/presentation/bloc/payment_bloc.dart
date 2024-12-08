import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/i_payment_repository.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final IPaymentRepository _paymentRepository;

  PaymentBloc({
    required IPaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        super(PaymentInitial()) {
    on<PaymentInitiateRequested>(_onPaymentInitiateRequested);
    on<PaymentConfirmRequested>(_onPaymentConfirmRequested);
    on<PaymentRefundRequested>(_onPaymentRefundRequested);
    on<CustomerPaymentsFetchRequested>(_onCustomerPaymentsFetchRequested);
    on<ProviderPaymentsFetchRequested>(_onProviderPaymentsFetchRequested);
  }

  Future<void> _onPaymentInitiateRequested(
    PaymentInitiateRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final payment = await _paymentRepository.initiatePayment(
        bookingId: event.bookingId,
        amount: event.amount,
        method: event.method,
        metadata: event.metadata,
      );
      emit(PaymentInitiated(payment));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onPaymentConfirmRequested(
    PaymentConfirmRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final payment = await _paymentRepository.confirmPayment(event.paymentId);
      emit(PaymentConfirmed(payment));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onPaymentRefundRequested(
    PaymentRefundRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      await _paymentRepository.refundPayment(
        event.paymentId,
        reason: event.reason,
      );
      emit(PaymentRefunded(
        paymentId: event.paymentId,
        reason: event.reason,
      ));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onCustomerPaymentsFetchRequested(
    CustomerPaymentsFetchRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final payments = await _paymentRepository.getCustomerPayments(event.customerId);
      emit(PaymentsLoaded(payments));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onProviderPaymentsFetchRequested(
    ProviderPaymentsFetchRequested event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final payments = await _paymentRepository.getProviderPayments(event.providerId);
      emit(PaymentsLoaded(payments));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
