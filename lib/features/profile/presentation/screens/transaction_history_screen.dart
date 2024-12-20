import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _dateFormat = DateFormat('dd/MM/yyyy');
  
  // Exemple de données de transactions
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'T001',
      'type': 'achat',
      'title': 'iPhone 13 Pro',
      'amount': 999.99,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'status': 'completed',
    },
    {
      'id': 'T002',
      'type': 'achat',
      'title': 'Samsung TV 4K',
      'amount': 799.99,
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'status': 'pending',
    },
    {
      'id': 'T003',
      'type': 'remboursement',
      'title': 'Casque Bluetooth',
      'amount': 79.99,
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'status': 'completed',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Historique',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Tout'),
            Tab(text: 'Achats'),
            Tab(text: 'Remboursements'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTransactionList(_transactions),
          _buildTransactionList(_transactions.where((t) => t['type'] == 'achat').toList()),
          _buildTransactionList(_transactions.where((t) => t['type'] == 'remboursement').toList()),
        ],
      ),
    );
  }

  Widget _buildTransactionList(List<Map<String, dynamic>> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune transaction',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => _showTransactionDetails(transaction),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          transaction['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${transaction['type'] == 'remboursement' ? '+' : '-'} ${transaction['amount'].toStringAsFixed(2)} €',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: transaction['type'] == 'remboursement' 
                              ? const Color(0xFF27AE60)
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dateFormat.format(transaction['date']),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      _buildStatusChip(transaction['status']),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    String label;
    
    switch (status) {
      case 'completed':
        backgroundColor = const Color(0xFF27AE60);
        label = 'Terminé';
        break;
      case 'pending':
        backgroundColor = Colors.orange;
        label = 'En cours';
        break;
      default:
        backgroundColor = Colors.grey;
        label = 'Inconnu';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: backgroundColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Détails de la transaction',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            _buildDetailRow('ID Transaction', '#${transaction['id']}'),
            _buildDetailRow('Article', transaction['title']),
            _buildDetailRow('Montant', '${transaction['amount'].toStringAsFixed(2)} €'),
            _buildDetailRow('Date', _dateFormat.format(transaction['date'])),
            _buildDetailRow('Type', transaction['type'].toString().toUpperCase()),
            _buildDetailRow('Statut', transaction['status'].toString().toUpperCase()),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27AE60),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // TODO: Implement receipt download
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Facture téléchargée'),
                      backgroundColor: Color(0xFF27AE60),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Télécharger la facture'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
