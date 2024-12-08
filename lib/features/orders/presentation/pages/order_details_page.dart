import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderId;

  const OrderDetailsPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simuler la récupération des détails de la commande
    final orderDetails = _mockOrderDetails[orderId] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Commande #$orderId'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusSection(orderDetails['status']),
            const SizedBox(height: 24),
            _buildServiceSection(orderDetails),
            const SizedBox(height: 24),
            _buildScheduleSection(orderDetails),
            const SizedBox(height: 24),
            _buildProviderSection(orderDetails),
            const SizedBox(height: 24),
            _buildPriceSection(orderDetails),
            if (orderDetails['status'] == 'completed')
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: _buildReviewSection(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection(String status) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statut de la commande',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatusTimeline(status),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(String currentStatus) {
    final statuses = [
      'pending',
      'confirmed',
      'in_progress',
      'completed',
    ];
    
    return Row(
      children: List.generate(statuses.length * 2 - 1, (index) {
        if (index.isOdd) {
          return Expanded(
            child: Container(
              height: 2,
              color: _isStatusReached(statuses[index ~/ 2], currentStatus)
                  ? const Color(0xFF27AE60)
                  : Colors.grey[300],
            ),
          );
        }

        final status = statuses[index ~/ 2];
        final isReached = _isStatusReached(status, currentStatus);

        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isReached ? const Color(0xFF27AE60) : Colors.grey[300],
          ),
          child: Icon(
            _getStatusIcon(status),
            size: 16,
            color: Colors.white,
          ),
        );
      }),
    );
  }

  bool _isStatusReached(String status, String currentStatus) {
    final statusOrder = {
      'pending': 0,
      'confirmed': 1,
      'in_progress': 2,
      'completed': 3,
      'cancelled': -1,
    };

    return statusOrder[currentStatus]! >= statusOrder[status]!;
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.hourglass_empty;
      case 'confirmed':
        return Icons.check;
      case 'in_progress':
        return Icons.engineering;
      case 'completed':
        return Icons.done_all;
      default:
        return Icons.circle;
    }
  }

  Widget _buildServiceSection(Map<String, dynamic> details) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Détails du service',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              details['serviceName'] ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              details['description'] ?? '',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleSection(Map<String, dynamic> details) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Horaire',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 12),
                Text(
                  details['date'] ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 24),
                Icon(
                  Icons.access_time,
                  size: 20,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 12),
                Text(
                  details['time'] ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            if (details['duration'] != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.timelapse,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Durée: ${details['duration']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProviderSection(Map<String, dynamic> details) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Prestataire',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.person,
                    size: 24,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        details['providerName'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (details['providerRating'] != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${details['providerRating']}',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection(Map<String, dynamic> details) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Détails du paiement',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Prix du service'),
                Text('${details['servicePrice']} FCFA'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Frais de service'),
                Text('${details['serviceFee']} FCFA'),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${details['total']} FCFA',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF27AE60),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Évaluation du service',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star_border,
                  size: 32,
                  color: Colors.amber[600],
                );
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Partagez votre expérience...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implémenter la soumission de l'évaluation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF27AE60),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Soumettre l\'évaluation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final Map<String, Map<String, dynamic>> _mockOrderDetails = {
  '1001': {
    'serviceName': 'Plomberie',
    'description': 'Réparation de fuite d\'eau dans la salle de bain',
    'providerName': 'Jean Dupont',
    'providerRating': 4.8,
    'date': '7 Dec 2024',
    'time': '14:30',
    'duration': '2 heures',
    'servicePrice': '12000',
    'serviceFee': '3000',
    'total': '15000',
    'status': 'confirmed',
  },
  '1002': {
    'serviceName': 'Électricité',
    'description': 'Installation de prises électriques',
    'providerName': 'Marie Martin',
    'providerRating': 4.5,
    'date': '8 Dec 2024',
    'time': '10:00',
    'duration': '3 heures',
    'servicePrice': '20000',
    'serviceFee': '5000',
    'total': '25000',
    'status': 'pending',
  },
  '1003': {
    'serviceName': 'Peinture',
    'description': 'Peinture complète du salon',
    'providerName': 'Paul Bernard',
    'providerRating': 4.9,
    'date': '6 Dec 2024',
    'time': '09:00',
    'duration': '6 heures',
    'servicePrice': '40000',
    'serviceFee': '10000',
    'total': '50000',
    'status': 'completed',
  },
};
