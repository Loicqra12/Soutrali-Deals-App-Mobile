import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Mon Panier',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        children: [
          // Articles du panier
          _buildCartItem(
            'Local',
            'Taille Unique',
            15000,
            25000,
            'Papa34',
          ),
          _buildCartItem(
            'Nike',
            'Pointure 30-40',
            20000,
            30000,
            'Popi 56',
          ),
          
          // Résumé de la commande
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
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
          onPressed: () => context.push('/checkout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF27AE60),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Passer la commande',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(
    String productName,
    String description,
    int price,
    int originalPrice,
    String sellerName,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // Image du produit
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.image, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            // Informations produit
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vendeur: $sellerName',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '$price FCFA',
                        style: const TextStyle(
                          color: Color(0xFF27AE60),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$originalPrice FCFA',
                        style: TextStyle(
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Quantité
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {},
                  color: Colors.grey[600],
                ),
                const Text('1'),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {},
                  color: const Color(0xFF27AE60),
                ),
              ],
            ),
          ],
        ),
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
