import 'package:flutter/material.dart';
import '../../data/favorites_service.dart';

class FavoriteButton extends StatefulWidget {
  final String freelancerId;
  final String userId;
  final FavoritesService favoritesService;

  const FavoriteButton({
    super.key,
    required this.freelancerId,
    required this.userId,
    required this.favoritesService,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFavorite = await widget.favoritesService.isFavorite(
      widget.userId,
      widget.freelancerId,
    );
    setState(() {
      _isFavorite = isFavorite;
      _isLoading = false;
    });
  }

  Future<void> _toggleFavorite() async {
    setState(() => _isLoading = true);
    try {
      final newStatus = await widget.favoritesService.toggleFavorite(
        widget.userId,
        widget.freelancerId,
      );
      setState(() => _isFavorite = newStatus);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isFavorite
                ? 'Ajouté aux favoris'
                : 'Retiré des favoris'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Une erreur est survenue'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _isLoading ? null : _toggleFavorite,
      icon: _isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
      tooltip: _isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
    );
  }
}
