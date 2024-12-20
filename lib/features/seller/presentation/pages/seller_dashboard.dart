import 'package:flutter/material.dart';
import '../widgets/seller_stats_card.dart';
import '../widgets/product_list_item.dart';
import '../widgets/order_list_item.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({super.key});

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Vendeur'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implémenter les notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Statistiques
            Row(
              children: [
                Expanded(
                  child: SellerStatsCard(
                    title: 'Ventes du jour',
                    value: '450€',
                    icon: Icons.euro,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SellerStatsCard(
                    title: 'Commandes',
                    value: '8',
                    icon: Icons.shopping_bag,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SellerStatsCard(
                    title: 'Produits',
                    value: '24',
                    icon: Icons.inventory,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SellerStatsCard(
                    title: 'Avis',
                    value: '4.8',
                    icon: Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Section Produits
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mes Produits',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Voir tous les produits
                  },
                  child: const Text('Voir tout'),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const ProductListItem(
                  name: 'Produit Example',
                  price: '29.99€',
                  stock: '15',
                  imageUrl: 'https://example.com/image.jpg',
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Section Commandes Récentes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Commandes Récentes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Voir toutes les commandes
                  },
                  child: const Text('Voir tout'),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const OrderListItem(
                  orderNumber: '#12345',
                  customerName: 'Client Example',
                  amount: '59.99€',
                  status: 'En cours',
                  date: '11 Dec 2024',
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Ajouter un nouveau produit
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
