import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Mes Favoris',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        children: [
          _buildFavoriteItem(
            'Local',
            'Taille Unique',
            15000,
            25000,
            'Papa34',
            context,
          ),
          _buildFavoriteItem(
            'Nike',
            'Pointure 30-40',
            20000,
            30000,
            'Popi 56',
            context,
          ),
          _buildFavoriteItem(
            'iPhone 13',
            '128 Go, Noir',
            450000,
            500000,
            'Tech Store',
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(
    String productName,
    String description,
    int price,
    int originalPrice,
    String sellerName,
    BuildContext context,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          final productId = productName.toLowerCase().replaceAll(' ', '-');
          context.push('/product/$productId');
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              // Image du produit
              Container(
                width: 100,
                height: 100,
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
              // Actions
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Color(0xFF27AE60)),
                    onPressed: () {
                      // Retirer des favoris
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      // Ajouter au panier
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ajouté au panier'),
                          backgroundColor: Color(0xFF27AE60),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
