import 'package:flutter/material.dart';

class OrderListItem extends StatelessWidget {
  final String orderNumber;
  final String customerName;
  final String amount;
  final String status;
  final String date;

  const OrderListItem({
    super.key,
    required this.orderNumber,
    required this.customerName,
    required this.amount,
    required this.status,
    required this.date,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'en cours':
        return Colors.orange;
      case 'livré':
        return Colors.green;
      case 'annulé':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Row(
          children: [
            Text(orderNumber),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: _getStatusColor(),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(customerName),
            Text(date),
          ],
        ),
        trailing: Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {
          // TODO: Naviguer vers les détails de la commande
        },
      ),
    );
  }
}
