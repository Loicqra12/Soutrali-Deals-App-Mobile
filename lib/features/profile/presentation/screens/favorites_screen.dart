import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Exemple de données
  final List<Map<String, dynamic>> _favoriteProducts = [
    {
      'id': '1',
      'name': 'iPhone 13 Pro',
      'price': 999.99,
      'image': 'https://via.placeholder.com/150',
      'inStock': true,
    },
    {
      'id': '2',
      'name': 'Samsung TV 4K',
      'price': 799.99,
      'image': 'https://via.placeholder.com/150',
      'inStock': false,
    },
  ];

  final List<Map<String, dynamic>> _favoriteServices = [
    {
      'id': '1',
      'name': 'Réparation iPhone',
      'price': 79.99,
      'image': 'https://via.placeholder.com/150',
      'rating': 4.5,
    },
    {
      'id': '2',
      'name': 'Installation TV',
      'price': 49.99,
      'image': 'https://via.placeholder.com/150',
      'rating': 4.8,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          'Mes Favoris',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Produits'),
            Tab(text: 'Services'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProductsList(),
          _buildServicesList(),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    if (_favoriteProducts.isEmpty) {
      return _buildEmptyState('Aucun produit favori');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _favoriteProducts.length,
      itemBuilder: (context, index) {
        final product = _favoriteProducts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              product['name'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product['price']} €',
                  style: const TextStyle(
                    color: Color(0xFF27AE60),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  product['inStock'] ? 'En stock' : 'Rupture de stock',
                  style: TextStyle(
                    color: product['inStock'] ? Colors.green : Colors.red,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                // TODO: Implement remove from favorites
                setState(() {
                  _favoriteProducts.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Retiré des favoris'),
                    backgroundColor: Color(0xFF27AE60),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildServicesList() {
    if (_favoriteServices.isEmpty) {
      return _buildEmptyState('Aucun service favori');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _favoriteServices.length,
      itemBuilder: (context, index) {
        final service = _favoriteServices[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                service['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              service['name'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${service['price']} €',
                  style: const TextStyle(
                    color: Color(0xFF27AE60),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber[700],
                    ),
                    Text(
                      ' ${service['rating']}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                // TODO: Implement remove from favorites
                setState(() {
                  _favoriteServices.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Retiré des favoris'),
                    backgroundColor: Color(0xFF27AE60),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
