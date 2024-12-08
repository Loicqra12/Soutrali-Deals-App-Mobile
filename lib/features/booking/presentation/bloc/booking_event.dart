import 'package:equatable/equatable.dart';
import '../../data/models/booking_model.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class BookingsFetchRequested extends BookingEvent {}

class CustomerBookingsFetchRequested extends BookingEvent {
  final String customerId;

  const CustomerBookingsFetchRequested(this.customerId);

  @override
  List<Object> get props => [customerId];
}

class ProviderBookingsFetchRequested extends BookingEvent {
  final String providerId;

  const ProviderBookingsFetchRequested(this.providerId);

  @override
  List<Object> get props => [providerId];
}

class BookingCreateRequested extends BookingEvent {
  final BookingModel booking;

  const BookingCreateRequested(this.booking);

  @override
  List<Object> get props => [booking];
}

class BookingUpdateRequested extends BookingEvent {
  final BookingModel booking;

  const BookingUpdateRequested(this.booking);

  @override
  List<Object> get props => [booking];
}

class BookingStatusUpdateRequested extends BookingEvent {
  final String bookingId;
  final BookingStatus status;

  const BookingStatusUpdateRequested({
    required this.bookingId,
    required this.status,
  });

  @override
  List<Object> get props => [bookingId, status];
}

class BookingCancelRequested extends BookingEvent {
  final String bookingId;
  final String? reason;

  const BookingCancelRequested({
    required this.bookingId,
    this.reason,
  });

  @override
  List<Object?> get props => [bookingId, reason];
}

class BookingsByStatusFetchRequested extends BookingEvent {
  final BookingStatus status;

  const BookingsByStatusFetchRequested(this.status);

  @override
  List<Object> get props => [status];
}
