import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text(
              'Marketplace',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () => context.push('/favorites'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () => context.push('/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.receipt_long, color: Colors.white),
            onPressed: () => context.push('/orders'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Rechercher un article...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () async {
                    final result = await context.push('/filters');
                    if (result != null) {
                      // TODO: Appliquer les filtres
                    }
                  },
                ),
              ],
            ),
          ),

          // Top Catégories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top Catégories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    _buildCategoryCard(
                      'Auto & Moto',
                      Icons.directions_car,
                      [
                        'Voitures',
                        'Motos',
                        'Pièces détachées',
                        'Accessoires auto',
                        'Équipement moto',
                        'Entretien',
                      ],
                    ),
                    _buildCategoryCard(
                      'Immobilier',
                      Icons.home,
                      [
                        'Appartements',
                        'Maisons',
                        'Terrains',
                        'Bureaux',
                        'Locations',
                        'Colocation',
                      ],
                    ),
                    _buildCategoryCard(
                      'Électronique',
                      Icons.phone_android,
                      [
                        'Smartphones',
                        'Ordinateurs',
                        'Tablettes',
                        'TV & Home Cinéma',
                        'Audio',
                        'Accessoires',
                      ],
                    ),
                    _buildCategoryCard(
                      'Mode',
                      Icons.checkroom,
                      [
                        'Vêtements Homme',
                        'Vêtements Femme',
                        'Chaussures',
                        'Accessoires',
                        'Montres & Bijoux',
                        'Sacs',
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Top articles
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top articles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                  children: [
                    _buildArticleCard(
                      'Papa34',
                      'Local',
                      'Taille Unique',
                      15000,
                      25000,
                      'assets/images/local.jpg',
                    ),
                    _buildArticleCard(
                      'Popi 56',
                      'Nike',
                      'Pointure 30-40',
                      20000,
                      30000,
                      'assets/images/nike.jpg',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, List<String> subCategories) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: subCategories.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(subCategories[index]),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            context.pop();
                            // TODO: Naviguer vers la sous-catégorie
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: const Color(0xFF27AE60),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(
    String sellerName,
    String productName,
    String description,
    int price,
    int originalPrice,
    String imagePath,
  ) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () {
          final productId = productName.toLowerCase().replaceAll(' ', '-');
          context.push('/product/$productId');
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vendeur
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(sellerName),
                  ],
                ),
              ),
              // Image du produit
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: const Icon(Icons.image, size: 40, color: Colors.grey),
                ),
              ),
              // Informations produit
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
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
            ],
          ),
        ),
      ),
    );
  }
}
