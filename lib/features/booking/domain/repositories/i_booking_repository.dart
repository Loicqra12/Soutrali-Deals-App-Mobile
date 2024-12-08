import '../../../../core/repositories/base_repository.dart';
import '../../data/models/booking_model.dart';

abstract class IBookingRepository extends BaseRepository<BookingModel> {
  Future<List<BookingModel>> getCustomerBookings(String customerId);
  Future<List<BookingModel>> getProviderBookings(String providerId);
  Future<BookingModel> updateStatus(String id, BookingStatus status);
  Future<List<BookingModel>> getByStatus(BookingStatus status);
  Future<bool> cancelBooking(String id, {String? reason});
}
