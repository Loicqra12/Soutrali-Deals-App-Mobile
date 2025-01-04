import 'package:shared_preferences.dart';
import '../domain/models/favorite.dart';
import 'dart:convert';

class FavoritesService {
  static const String _favoritesKey = 'favorites';
  final SharedPreferences _prefs;

  FavoritesService(this._prefs);

  Future<List<Favorite>> getFavorites(String userId) async {
    final String? favoritesJson = _prefs.getString(_favoritesKey);
    if (favoritesJson == null) return [];

    final List<dynamic> favoritesList = json.decode(favoritesJson);
    return favoritesList
        .map((json) => Favorite(
              id: json['id'],
              userId: json['userId'],
              freelancerId: json['freelancerId'],
              createdAt: DateTime.parse(json['createdAt']),
            ))
        .where((favorite) => favorite.userId == userId)
        .toList();
  }

  Future<bool> toggleFavorite(String userId, String freelancerId) async {
    final favorites = await getFavorites(userId);
    bool isFavorite = favorites.any((f) => f.freelancerId == freelancerId);

    if (isFavorite) {
      favorites.removeWhere(
          (favorite) => favorite.freelancerId == freelancerId && favorite.userId == userId);
    } else {
      favorites.add(Favorite.create(
        userId: userId,
        freelancerId: freelancerId,
      ));
    }

    final List<Map<String, dynamic>> favoritesJson = favorites
        .map((favorite) => {
              'id': favorite.id,
              'userId': favorite.userId,
              'freelancerId': favorite.freelancerId,
              'createdAt': favorite.createdAt.toIso8601String(),
            })
        .toList();

    await _prefs.setString(_favoritesKey, json.encode(favoritesJson));
    return !isFavorite;
  }

  Future<bool> isFavorite(String userId, String freelancerId) async {
    final favorites = await getFavorites(userId);
    return favorites.any((f) => f.freelancerId == freelancerId);
  }
}
