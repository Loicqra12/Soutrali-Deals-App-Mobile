import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences.dart';
import '../domain/models/booking.dart';

class BookingService {
  static const String _bookingsKey = 'bookings';
  final SharedPreferences _prefs;
  final StreamController<List<Booking>> _bookingsController = StreamController<List<Booking>>.broadcast();

  BookingService(this._prefs);

  Stream<List<Booking>> get bookingsStream => _bookingsController.stream;

  Future<List<Booking>> getClientBookings(String clientId) async {
    final bookings = await _getAllBookings();
    return bookings
        .where((booking) => booking.clientId == clientId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<List<Booking>> getFreelancerBookings(String freelancerId) async {
    final bookings = await _getAllBookings();
    return bookings
        .where((booking) => booking.freelancerId == freelancerId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<List<Booking>> getBookingsByStatus(String userId, BookingStatus status) async {
    final bookings = await _getAllBookings();
    return bookings
        .where((booking) =>
            (booking.clientId == userId || booking.freelancerId == userId) &&
            booking.status == status)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> createBooking(Booking booking) async {
    final bookings = await _getAllBookings();
    bookings.add(booking);
    await _saveBookings(bookings);
    _notifyListeners();
  }

  Future<void> updateBookingStatus(
    String bookingId,
    BookingStatus status, {
    String? cancellationReason,
  }) async {
    final bookings = await _getAllBookings();
    final index = bookings.indexWhere((b) => b.id == bookingId);
    if (index >= 0) {
      bookings[index] = bookings[index].copyWith(
        status: status,
        cancellationReason: cancellationReason,
      );
      await _saveBookings(bookings);
      _notifyListeners();
    }
  }

  Future<void> cancelBooking(String bookingId, String reason) async {
    await updateBookingStatus(
      bookingId,
      BookingStatus.cancelled,
      cancellationReason: reason,
    );
  }

  Future<void> declineBooking(String bookingId, String reason) async {
    await updateBookingStatus(
      bookingId,
      BookingStatus.declined,
      cancellationReason: reason,
    );
  }

  Future<void> confirmBooking(String bookingId) async {
    await updateBookingStatus(bookingId, BookingStatus.confirmed);
  }

  Future<void> completeBooking(String bookingId) async {
    await updateBookingStatus(bookingId, BookingStatus.completed);
  }

  Future<List<Booking>> _getAllBookings() async {
    final String? bookingsJson = _prefs.getString(_bookingsKey);
    if (bookingsJson == null) return [];

    final List<dynamic> bookingsList = json.decode(bookingsJson);
    return bookingsList.map((json) => _bookingFromJson(json)).toList();
  }

  Future<void> _saveBookings(List<Booking> bookings) async {
    final List<Map<String, dynamic>> bookingsJson =
        bookings.map((booking) => _bookingToJson(booking)).toList();
    await _prefs.setString(_bookingsKey, json.encode(bookingsJson));
  }

  void _notifyListeners() async {
    final bookings = await _getAllBookings();
    _bookingsController.add(bookings);
  }

  Map<String, dynamic> _bookingToJson(Booking booking) {
    return {
      'id': booking.id,
      'freelancerId': booking.freelancerId,
      'clientId': booking.clientId,
      'startDate': booking.startDate.toIso8601String(),
      'endDate': booking.endDate.toIso8601String(),
      'serviceTitle': booking.serviceTitle,
      'serviceDescription': booking.serviceDescription,
      'amount': booking.amount,
      'status': booking.status.toString(),
      'cancellationReason': booking.cancellationReason,
      'createdAt': booking.createdAt.toIso8601String(),
      'requirements': booking.requirements,
      'additionalDetails': booking.additionalDetails,
    };
  }

  Booking _bookingFromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      freelancerId: json['freelancerId'],
      clientId: json['clientId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      serviceTitle: json['serviceTitle'],
      serviceDescription: json['serviceDescription'],
      amount: json['amount'].toDouble(),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      cancellationReason: json['cancellationReason'],
      createdAt: DateTime.parse(json['createdAt']),
      requirements: List<String>.from(json['requirements']),
      additionalDetails: json['additionalDetails'],
    );
  }

  void dispose() {
    _bookingsController.close();
  }
}
