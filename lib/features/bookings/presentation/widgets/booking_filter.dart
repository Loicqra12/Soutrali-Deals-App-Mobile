import 'package:flutter/material.dart';
import '../../domain/models/booking.dart';

class BookingFilter extends StatelessWidget {
  final BookingStatus? selectedStatus;
  final ValueChanged<BookingStatus?> onStatusChanged;

  const BookingFilter({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _FilterChip(
            label: 'Toutes',
            isSelected: selectedStatus == null,
            onSelected: (selected) {
              if (selected) {
                onStatusChanged(null);
              }
            },
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'En attente',
            isSelected: selectedStatus == BookingStatus.pending,
            onSelected: (selected) {
              onStatusChanged(
                  selected ? BookingStatus.pending : null);
            },
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Confirmées',
            isSelected: selectedStatus == BookingStatus.confirmed,
            onSelected: (selected) {
              onStatusChanged(
                  selected ? BookingStatus.confirmed : null);
            },
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Terminées',
            isSelected: selectedStatus == BookingStatus.completed,
            onSelected: (selected) {
              onStatusChanged(
                  selected ? BookingStatus.completed : null);
            },
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Annulées',
            isSelected: selectedStatus == BookingStatus.cancelled,
            onSelected: (selected) {
              onStatusChanged(
                  selected ? BookingStatus.cancelled : null);
            },
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Refusées',
            isSelected: selectedStatus == BookingStatus.declined,
            onSelected: (selected) {
              onStatusChanged(
                  selected ? BookingStatus.declined : null);
            },
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      checkmarkColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).primaryColor
            : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
