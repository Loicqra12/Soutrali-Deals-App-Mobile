import '../../../../core/repositories/base_repository.dart';
import '../../data/models/payment_model.dart';

abstract class IPaymentRepository extends BaseRepository<PaymentModel> {
  Future<PaymentModel> initiatePayment({
    required String bookingId,
    required double amount,
    required PaymentMethod method,
    Map<String, dynamic>? metadata,
  });
  Future<PaymentModel> confirmPayment(String paymentId);
  Future<bool> refundPayment(String paymentId, {String? reason});
  Future<List<PaymentModel>> getCustomerPayments(String customerId);
  Future<List<PaymentModel>> getProviderPayments(String providerId);
}
