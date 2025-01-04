import 'package:flutter/material.dart';
import '../../data/booking_service.dart';
import '../../domain/models/booking.dart';
import 'package:intl/intl.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;
  final bool isFreelancer;
  final BookingService bookingService;

  const BookingCard({
    super.key,
    required this.booking,
    required this.isFreelancer,
    required this.bookingService,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'fr_CI',
      symbol: 'FCFA',
      decimalDigits: 0,
    );

    final dateFormat = DateFormat('dd MMM yyyy HH:mm', 'fr_FR');

    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (booking.status) {
      case BookingStatus.pending:
        statusColor = Colors.orange;
        statusIcon = Icons.schedule;
        statusText = 'En attente';
        break;
      case BookingStatus.confirmed:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = 'Confirmée';
        break;
      case BookingStatus.completed:
        statusColor = Colors.blue;
        statusIcon = Icons.task_alt;
        statusText = 'Terminée';
        break;
      case BookingStatus.cancelled:
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        statusText = 'Annulée';
        break;
      case BookingStatus.declined:
        statusColor = Colors.red[700]!;
        statusIcon = Icons.block;
        statusText = 'Refusée';
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      statusIcon,
                      color: statusColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      currencyFormat.format(booking.amount),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Text(
                  booking.serviceTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  booking.serviceDescription,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Du ${dateFormat.format(booking.startDate)} au ${dateFormat.format(booking.endDate)}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                if (booking.requirements.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Exigences :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: booking.requirements.map((requirement) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          requirement,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                if (booking.cancellationReason != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.red[100]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.red[700],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            booking.cancellationReason!,
                            style: TextStyle(
                              color: Colors.red[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (booking.status == BookingStatus.pending) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      final reason = await showDialog<String>(
                        context: context,
                        builder: (context) => _CancellationDialog(
                          title: isFreelancer ? 'Refuser' : 'Annuler',
                        ),
                      );

                      if (reason != null) {
                        if (isFreelancer) {
                          await bookingService.declineBooking(
                            booking.id,
                            reason,
                          );
                        } else {
                          await bookingService.cancelBooking(
                            booking.id,
                            reason,
                          );
                        }
                      }
                    },
                    child: Text(
                      isFreelancer ? 'Refuser' : 'Annuler',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (isFreelancer)
                    FilledButton(
                      onPressed: () async {
                        await bookingService.confirmBooking(booking.id);
                      },
                      child: const Text('Accepter'),
                    ),
                ],
              ),
            ),
          ] else if (booking.status == BookingStatus.confirmed && isFreelancer) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: () async {
                      await bookingService.completeBooking(booking.id);
                    },
                    child: const Text('Marquer comme terminé'),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CancellationDialog extends StatefulWidget {
  final String title;

  const _CancellationDialog({
    required this.title,
  });

  @override
  State<_CancellationDialog> createState() => _CancellationDialogState();
}

class _CancellationDialogState extends State<_CancellationDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.title} la réservation'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Motif',
          hintText: 'Veuillez indiquer la raison...',
          border: OutlineInputBorder(),
        ),
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: () {
            if (_controller.text.trim().isNotEmpty) {
              Navigator.pop(context, _controller.text.trim());
            }
          },
          child: Text(widget.title),
        ),
      ],
    );
  }
}
