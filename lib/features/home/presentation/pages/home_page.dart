import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/promotion_carousel.dart';
import '../widgets/category_grid.dart';
import '../widgets/popular_services.dart';
import '../widgets/featured_products.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingButton = false;
  bool _isLoading = true;
  String? _error;
  
  List<Map<String, dynamic>> _groupes = [];
  Map<String, List<Map<String, dynamic>>> _categoriesParGroupe = {};
  Map<String, List<Map<String, dynamic>>> _servicesParCategorie = {};

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(() {
      setState(() {
        _showFloatingButton = _scrollController.offset > 200;
      });
    });
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // 1. Charger les groupes
      final groupesResponse = await http.get(Uri.parse('http://localhost:3000/api/groupe'));
      if (groupesResponse.statusCode == 200) {
        final List<dynamic> groupesData = json.decode(groupesResponse.body);
        
        // 2. Pour chaque groupe, charger ses catégories
        final categoriesMap = <String, List<Map<String, dynamic>>>{};
        final servicesMap = <String, List<Map<String, dynamic>>>{};
        
        for (var groupe in groupesData) {
          final categoriesResponse = await http.get(
            Uri.parse('http://localhost:3000/api/categorie?groupe=${groupe['_id']}')
          );
          if (categoriesResponse.statusCode == 200) {
            final List<dynamic> categoriesData = json.decode(categoriesResponse.body);
            categoriesMap[groupe['_id']] = List<Map<String, dynamic>>.from(categoriesData);
            
            // 3. Pour chaque catégorie, charger ses services
            for (var categorie in categoriesData) {
              final servicesResponse = await http.get(
                Uri.parse('http://localhost:3000/api/service?categorie=${categorie['_id']}')
              );
              if (servicesResponse.statusCode == 200) {
                final List<dynamic> servicesData = json.decode(servicesResponse.body);
                servicesMap[categorie['_id']] = List<Map<String, dynamic>>.from(servicesData);
              }
            }
          }
        }

        setState(() {
          _groupes = List<Map<String, dynamic>>.from(groupesData);
          _categoriesParGroupe = categoriesMap;
          _servicesParCategorie = servicesMap;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
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
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Erreur: $_error'),
              ElevatedButton(
                onPressed: _loadData,
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
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
                    _buildGroupesSection(),
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

  Widget _buildGroupesSection() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _groupes.length,
      itemBuilder: (context, index) {
        final groupe = _groupes[index];
        final categories = _categoriesParGroupe[groupe['_id']] ?? [];
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    groupe['nomgroupe'],
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigation vers toutes les catégories du groupe
                    },
                    child: const Text('Voir tout'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final categorie = categories[index];
                  return _buildCategorieCard(categorie);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategorieCard(Map<String, dynamic> categorie) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () {
          // Navigation vers les services de la catégorie
        },
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                categorie['imagecategorie'],
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.category,
                    size: 48,
                    color: Color(0xFF27AE60),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                categorie['nomcategorie'],
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF27AE60),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.go('/profile');
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Text(
                    'SD',
                    style: TextStyle(
                      color: Color(0xFF27AE60),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'SOUTRALI DEALS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => context.go('/register'),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text(
                  'Connexion',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white),
              const SizedBox(width: 8),
              const Text(
                'Toute la Côte d\'ivoire',
                style: TextStyle(color: Colors.white),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.pushNamed('provider_registration');
                },
                child: const Text(
                  'Devenir prestataire',
                  style: TextStyle(color: Colors.white, fontSize: 14),
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
}
