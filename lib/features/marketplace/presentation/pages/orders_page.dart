import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF27AE60),
          title: const Text(
            'Mes Commandes',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'En cours'),
              Tab(text: 'Livrées'),
              Tab(text: 'Annulées'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrdersList('en_cours'),
            _buildOrdersList('livrees'),
            _buildOrdersList('annulees'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(String status) {
    return ListView(
      children: [
        _buildOrderItem(
          orderNumber: 'CMD-001',
          date: '05 Dec 2024',
          items: ['Local', 'Nike'],
          total: 35000,
          status: status,
        ),
        _buildOrderItem(
          orderNumber: 'CMD-002',
          date: '03 Dec 2024',
          items: ['iPhone 13'],
          total: 450000,
          status: status,
        ),
      ],
    );
  }

  Widget _buildOrderItem({
    required String orderNumber,
    required String date,
    required List<String> items,
    required int total,
    required String status,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête de la commande
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Commande $orderNumber',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Divider(),
            // Articles
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '• $item',
                    style: const TextStyle(fontSize: 14),
                  ),
                )),
            const SizedBox(height: 8),
            // Total et statut
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: $total FCFA',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF27AE60),
                  ),
                ),
                _buildStatusChip(status),
              ],
            ),
            const SizedBox(height: 8),
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (status == 'en_cours') ...[
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Annuler',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                TextButton(
                  onPressed: () {},
                  child: const Text('Voir les détails'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case 'en_cours':
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[900]!;
        label = 'En cours';
        break;
      case 'livrees':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[900]!;
        label = 'Livrée';
        break;
      case 'annulees':
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[900]!;
        label = 'Annulée';
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[900]!;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
