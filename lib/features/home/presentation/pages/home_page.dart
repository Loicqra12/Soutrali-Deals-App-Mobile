import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soutrali_deals/features/home/presentation/widgets/promotion_carousel.dart';
import 'package:soutrali_deals/features/home/presentation/widgets/category_grid.dart';
import 'package:soutrali_deals/features/home/presentation/widgets/popular_services.dart';
import 'package:soutrali_deals/features/home/presentation/widgets/featured_products.dart';
import 'package:soutrali_deals/shared/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showFloatingButton = _scrollController.offset > 200;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // TODO: Implémenter le rafraîchissement
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    const PromotionCarousel(),
                    _buildQuickActions(),
                    const CategoryGrid(),
                    const PopularServices(),
                    const FeaturedProducts(),
                    _buildRecommendedSection(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _showFloatingButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              mini: true,
              backgroundColor: const Color(0xFF27AE60),
              child: const Icon(Icons.arrow_upward),
            )
          : null,
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF27AE60),
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.go('/profile');
            },
            child: const CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage('https://via.placeholder.com/30'),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'SOUTRALI DEALS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            // TODO: Navigation vers les notifications
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            // TODO: Navigation vers le panier
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              const Text(
                'Toute la Côte d\'ivoire',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Navigation vers la sélection de localisation
                },
                child: const Text(
                  'Changer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Navigation vers la recherche
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Rechercher sur soutralideal',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services Rapides',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuickActionItem(
                icon: Icons.home_repair_service,
                label: 'Services',
                onTap: () {
                  // TODO: Navigation vers les services
                },
              ),
              _buildQuickActionItem(
                icon: Icons.shopping_bag,
                label: 'Produits',
                onTap: () {
                  // TODO: Navigation vers les produits
                },
              ),
              _buildQuickActionItem(
                icon: Icons.schedule,
                label: 'Réservations',
                onTap: () {
                  // TODO: Navigation vers les réservations
                },
              ),
              _buildQuickActionItem(
                icon: Icons.local_offer,
                label: 'Offres',
                onTap: () {
                  // TODO: Navigation vers les offres
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF27AE60).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF27AE60),
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recommandés pour vous',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigation vers plus de recommandations
                },
                child: const Text('Voir plus'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildRecommendedItem();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              'https://via.placeholder.com/150',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Titre du produit',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '15.000 FCFA',
                  style: TextStyle(
                    color: Color(0xFF27AE60),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Text('4.5'),
                    Spacer(),
                    Text(
                      'Abidjan',
                      style: TextStyle(
                        color: Colors.grey,
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
    );
  }
}
