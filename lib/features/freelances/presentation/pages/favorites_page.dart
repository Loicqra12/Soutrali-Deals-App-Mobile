import 'package:flutter/material.dart';
import '../../data/favorites_service.dart';
import '../../data/freelancers_data.dart';
import '../../domain/models/freelancer.dart';
import '../widgets/freelancer_card.dart';

class FavoritesPage extends StatefulWidget {
  final String userId;
  final FavoritesService favoritesService;

  const FavoritesPage({
    super.key,
    required this.userId,
    required this.favoritesService,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Freelancer> _favoriteFreelancers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => _isLoading = true);
    try {
      final favorites = await widget.favoritesService.getFavorites(widget.userId);
      final favoriteFreelancers = mockFreelancers
          .where((freelancer) =>
              favorites.any((f) => f.freelancerId == freelancer.id))
          .toList();
      setState(() => _favoriteFreelancers = favoriteFreelancers);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors du chargement des favoris'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Favoris'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favoriteFreelancers.isEmpty
              ? Center(
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
                        'Aucun favori pour le moment',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ajoutez des freelances à vos favoris\npour les retrouver ici',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadFavorites,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _favoriteFreelancers.length,
                    itemBuilder: (context, index) {
                      final freelancer = _favoriteFreelancers[index];
                      return FreelancerCard(
                        freelancer: freelancer,
                        favoritesService: widget.favoritesService,
                        currentUserId: widget.userId,
                        onTap: () {
                          // TODO: Naviguer vers la page de détails du freelance
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
