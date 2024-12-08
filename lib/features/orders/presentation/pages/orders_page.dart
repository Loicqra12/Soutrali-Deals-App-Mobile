import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes commandes'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockOrders.length,
        itemBuilder: (context, index) {
          final order = _mockOrders[index];
          return _buildOrderCard(context, order);
        },
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          context.push('/order-details/${order['id']}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Commande #${order['id']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _buildStatusChip(order['status']),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                order['serviceName'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                order['providerName'],
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order['date'],
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order['time'],
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '${order['total']} FCFA',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF27AE60),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        label = 'En attente';
        break;
      case 'confirmed':
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[800]!;
        label = 'Confirmé';
        break;
      case 'in_progress':
        backgroundColor = Colors.purple[100]!;
        textColor = Colors.purple[800]!;
        label = 'En cours';
        break;
      case 'completed':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        label = 'Terminé';
        break;
      case 'cancelled':
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        label = 'Annulé';
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[800]!;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _mockOrders = [
  {
    'id': '1001',
    'serviceName': 'Plomberie',
    'providerName': 'Jean Dupont',
    'date': '7 Dec 2024',
    'time': '14:30',
    'total': '15000',
    'status': 'confirmed',
  },
  {
    'id': '1002',
    'serviceName': 'Électricité',
    'providerName': 'Marie Martin',
    'date': '8 Dec 2024',
    'time': '10:00',
    'total': '25000',
    'status': 'pending',
  },
  {
    'id': '1003',
    'serviceName': 'Peinture',
    'providerName': 'Paul Bernard',
    'date': '6 Dec 2024',
    'time': '09:00',
    'total': '50000',
    'status': 'completed',
  },
  {
    'id': '1004',
    'serviceName': 'Jardinage',
    'providerName': 'Sophie Petit',
    'date': '5 Dec 2024',
    'time': '16:00',
    'total': '12000',
    'status': 'cancelled',
  },
  {
    'id': '1005',
    'serviceName': 'Menuiserie',
    'providerName': 'Luc Dubois',
    'date': '7 Dec 2024',
    'time': '11:30',
    'total': '35000',
    'status': 'in_progress',
  },
];
