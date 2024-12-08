import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Paiement',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Adresse de livraison
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Adresse de livraison',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Modifier'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Jean Dupont'),
                  const Text('123 Rue du Commerce'),
                  const Text('Abidjan, Cocody'),
                  const Text('Contact: +225 0123456789'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Mode de paiement
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mode de paiement',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPaymentMethod(
                    'Orange Money',
                    Icons.phone_android,
                    isSelected: true,
                  ),
                  _buildPaymentMethod(
                    'MTN Mobile Money',
                    Icons.phone_android,
                  ),
                  _buildPaymentMethod(
                    'Wave',
                    Icons.credit_card,
                  ),
                  _buildPaymentMethod(
                    'Carte bancaire',
                    Icons.credit_card,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Résumé de la commande
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Résumé de la commande',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryRow('Sous-total', '35.000 FCFA'),
                  _buildSummaryRow('Livraison', '2.000 FCFA'),
                  _buildSummaryRow('Réduction', '-5.000 FCFA'),
                  const Divider(),
                  _buildSummaryRow(
                    'Total',
                    '32.000 FCFA',
                    isBold: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implémenter le paiement
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirmation'),
                content: const Text(
                  'Votre commande a été passée avec succès !',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop(); // Ferme le dialog
                      context.go('/marketplace'); // Retourne au marketplace
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF27AE60),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Confirmer le paiement',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(
    String name,
    IconData icon, {
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? const Color(0xFF27AE60) : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF27AE60) : Colors.grey[600],
        ),
        title: Text(
          name,
          style: TextStyle(
            color: isSelected ? const Color(0xFF27AE60) : null,
            fontWeight: isSelected ? FontWeight.bold : null,
          ),
        ),
        trailing: isSelected
            ? const Icon(
                Icons.check_circle,
                color: Color(0xFF27AE60),
              )
            : null,
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? const Color(0xFF27AE60) : null,
            ),
          ),
        ],
      ),
    );
  }
}
