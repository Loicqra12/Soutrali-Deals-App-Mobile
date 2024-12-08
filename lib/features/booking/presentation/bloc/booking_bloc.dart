import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/i_booking_repository.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final IBookingRepository _bookingRepository;

  BookingBloc({
    required IBookingRepository bookingRepository,
  })  : _bookingRepository = bookingRepository,
        super(BookingInitial()) {
    on<BookingsFetchRequested>(_onBookingsFetchRequested);
    on<CustomerBookingsFetchRequested>(_onCustomerBookingsFetchRequested);
    on<ProviderBookingsFetchRequested>(_onProviderBookingsFetchRequested);
    on<BookingCreateRequested>(_onBookingCreateRequested);
    on<BookingUpdateRequested>(_onBookingUpdateRequested);
    on<BookingStatusUpdateRequested>(_onBookingStatusUpdateRequested);
    on<BookingCancelRequested>(_onBookingCancelRequested);
    on<BookingsByStatusFetchRequested>(_onBookingsByStatusFetchRequested);
  }

  Future<void> _onBookingsFetchRequested(
    BookingsFetchRequested event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      final bookings = await _bookingRepository.getAll();
      emit(BookingsLoaded(bookings));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onCustomerBookingsFetchRequested(
    CustomerBookingsFetchRequested event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      final bookings = await _bookingRepository.getCustomerBookings(event.customerId);
      emit(BookingsLoaded(bookings));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onProviderBookingsFetchRequested(
    ProviderBookingsFetchRequested event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      final bookings = await _bookingRepository.getProviderBookings(event.providerId);
      emit(BookingsLoaded(bookings));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onBookingCreateRequested(
    BookingCreateRequested event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      final booking = await _bookingRepository.create(event.booking);
      emit(BookingOperationSuccess('Booking created successfully', booking));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onBookingUpdateRequested(
    BookingUpdateRequested event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      final booking = await _bookingRepository.update(event.booking);
      emit(BookingOperationSuccess('Booking updated successfully', booking));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onBookingStatusUpdateRequested(
    BookingStatusUpdateRequested event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      final booking = await _bookingRepository.updateStatus(
        event.bookingId,
        event.status,
      );
      emit(BookingOperationSuccess('Booking status updated successfully', booking));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onBookingCancelRequested(
    BookingCancelRequested event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      await _bookingRepository.cancelBooking(
        event.bookingId,
        reason: event.reason,
      );
      emit(BookingCancelled(
        bookingId: event.bookingId,
        reason: event.reason,
      ));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> _onBookingsByStatusFetchRequested(
    BookingsByStatusFetchRequested event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      final bookings = await _bookingRepository.getByStatus(event.status);
      emit(BookingsLoaded(bookings));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
