import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // En-tête avec les 4 catégories principales
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMainCategory(
                    'Prestation\nde service',
                    Icons.handyman,
                    isSelected: true,
                  ),
                  _buildMainCategory(
                    'E-\ncommerce',
                    Icons.shopping_cart,
                  ),
                  _buildMainCategory(
                    'Crypto\nStore',
                    Icons.currency_bitcoin,
                  ),
                  _buildMainCategory(
                    'Petite\nAnnonce',
                    Icons.campaign,
                  ),
                ],
              ),
            ),
          ),

          // Section Métiers
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Métiers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildJobTile('Maçonnerie'),
                      _buildJobTile('Menuisier'),
                      _buildJobTile('Mécanique'),
                      _buildJobTile('Plomberie'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Section Prestataires
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Prestataires',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildProviderCard('Marc'),
                        _buildProviderCard('Elie'),
                        _buildProviderCard('Tratra'),
                        _buildProviderCard('OLI'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildMainCategory(String title, IconData icon, {bool isSelected = false}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF27AE60) : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey[600],
            size: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? const Color(0xFF27AE60) : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildJobTile(String title) {
    return Builder(
      builder: (context) => ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.work, color: Colors.grey[600]),
        ),
        title: Text(title),
        subtitle: const Text('Catégorie'),
        onTap: () {
          // Convertir le titre en ID pour la route (en minuscules et sans accents)
          final categoryId = title.toLowerCase()
              .replaceAll(RegExp(r'[éèêë]'), 'e')
              .replaceAll(RegExp(r'[àâä]'), 'a')
              .replaceAll(RegExp(r'[îï]'), 'i')
              .replaceAll(RegExp(r'[ôö]'), 'o')
              .replaceAll(RegExp(r'[ûüù]'), 'u')
              .replaceAll(RegExp(r'[ç]'), 'c')
              .replaceAll(' ', '_');
          context.push('/services/category/$categoryId');
        },
      ),
    );
  }

  Widget _buildProviderCard(String name) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () {
          // Convertir le nom en ID pour la route
          final providerId = name.toLowerCase();
          context.push('/provider/$providerId');
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person),
              ),
              const SizedBox(height: 8),
              Text(name),
              const Text(
                '1000 FCFA',
                style: TextStyle(
                  color: Color(0xFF27AE60),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
