import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/article.dart';
import '../../domain/models/market_category.dart';

class MarketplaceService {
  // L'URL du backend
  static const String baseUrl = 'http://localhost:3000/api';
  
  Future<List<T>> _handleListResponse<T>(Future<http.Response> Function() request, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await request();
      print('Response status: ${response.statusCode}'); // Debug
      print('Response body: ${response.body}'); // Debug
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Erreur serveur: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Erreur dans la requête: $e'); // Pour le débogage
      throw Exception('Erreur réseau: $e');
    }
  }

  Future<T> _handleSingleResponse<T>(Future<http.Response> Function() request, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await request();
      print('Response status: ${response.statusCode}'); // Debug
      print('Response body: ${response.body}'); // Debug
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return fromJson(data as Map<String, dynamic>);
      } else {
        throw Exception('Erreur serveur: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Erreur dans la requête: $e'); // Pour le débogage
      throw Exception('Erreur réseau: $e');
    }
  }

  // Récupérer tous les articles
  Future<List<Article>> getAllArticles() async {
    return _handleListResponse(
      () => http.get(
        Uri.parse('$baseUrl/articles'),
        headers: {'Accept': 'application/json'},
      ),
      (json) => Article.fromJson(json),
    );
  }

  // Récupérer toutes les catégories
  Future<List<MarketCategory>> getAllCategories() async {
    return _handleListResponse(
      () => http.get(
        Uri.parse('$baseUrl/categorie'),
        headers: {'Accept': 'application/json'},
      ),
      (json) => MarketCategory.fromJson(json),
    );
  }

  // Récupérer les articles d'une catégorie
  Future<List<Article>> getArticlesByCategory(String categoryId) async {
    return _handleListResponse(
      () => http.get(
        Uri.parse('$baseUrl/articles?categorie=$categoryId'),
        headers: {'Accept': 'application/json'},
      ),
      (json) => Article.fromJson(json),
    );
  }

  // Récupérer les détails d'un article
  Future<Article> getArticleDetails(String articleId) async {
    return _handleSingleResponse(
      () => http.get(
        Uri.parse('$baseUrl/article/$articleId'),
        headers: {'Accept': 'application/json'},
      ),
      (json) => Article.fromJson(json),
    );
  }
}
