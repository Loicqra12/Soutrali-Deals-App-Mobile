import 'package:equatable/equatable.dart';
import '../../data/models/booking_model.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingsLoaded extends BookingState {
  final List<BookingModel> bookings;

  const BookingsLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object> get props => [message];
}

class BookingOperationSuccess extends BookingState {
  final String message;
  final BookingModel? booking;

  const BookingOperationSuccess(this.message, [this.booking]);

  @override
  List<Object?> get props => [message, booking];
}

class BookingCancelled extends BookingState {
  final String bookingId;
  final String? reason;

  const BookingCancelled({
    required this.bookingId,
    this.reason,
  });

  @override
  List<Object?> get props => [bookingId, reason];
}
