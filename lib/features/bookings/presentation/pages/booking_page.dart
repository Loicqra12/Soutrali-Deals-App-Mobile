import 'package:flutter/material.dart';
import '../../data/booking_service.dart';
import '../../domain/models/booking.dart';
import '../widgets/booking_card.dart';
import '../widgets/booking_filter.dart';

class BookingPage extends StatefulWidget {
  final String userId;
  final bool isFreelancer;
  final BookingService bookingService;

  const BookingPage({
    super.key,
    required this.userId,
    required this.isFreelancer,
    required this.bookingService,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<Booking> _bookings = [];
  BookingStatus? _selectedStatus;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBookings();
    widget.bookingService.bookingsStream.listen((bookings) {
      if (mounted) {
        _loadBookings();
      }
    });
  }

  Future<void> _loadBookings() async {
    setState(() => _isLoading = true);
    try {
      final bookings = _selectedStatus != null
          ? await widget.bookingService.getBookingsByStatus(
              widget.userId,
              _selectedStatus!,
            )
          : widget.isFreelancer
              ? await widget.bookingService.getFreelancerBookings(widget.userId)
              : await widget.bookingService.getClientBookings(widget.userId);

      if (mounted) {
        setState(() {
          _bookings = bookings;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors du chargement des réservations'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réservations'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BookingFilter(
            selectedStatus: _selectedStatus,
            onStatusChanged: (status) {
              setState(() {
                _selectedStatus = status;
              });
              _loadBookings();
            },
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _bookings.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Aucune réservation',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _selectedStatus != null
                                  ? 'Aucune réservation ${_getStatusText(_selectedStatus!)}'
                                  : widget.isFreelancer
                                      ? 'Vous n\'avez pas encore reçu de réservations'
                                      : 'Vous n\'avez pas encore effectué de réservations',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadBookings,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _bookings.length,
                          itemBuilder: (context, index) {
                            final booking = _bookings[index];
                            return BookingCard(
                              booking: booking,
                              isFreelancer: widget.isFreelancer,
                              bookingService: widget.bookingService,
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  String _getStatusText(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return 'en attente';
      case BookingStatus.confirmed:
        return 'confirmée';
      case BookingStatus.completed:
        return 'terminée';
      case BookingStatus.cancelled:
        return 'annulée';
      case BookingStatus.declined:
        return 'refusée';
    }
  }
}
