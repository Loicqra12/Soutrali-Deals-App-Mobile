import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/groupe_model.dart';
import '../models/categorie_model.dart';
import '../models/service_model.dart';

class HomeService {
  static const String baseUrl = 'http://localhost:3000/api';

  Future<List<GroupeModel>> getGroupes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/groupe'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => GroupeModel.fromJson(json)).toList();
      }
      throw Exception('Erreur lors du chargement des groupes');
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  Future<List<CategorieModel>> getCategoriesByGroupe(String groupeId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categorie?groupe=$groupeId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CategorieModel.fromJson(json)).toList();
      }
      throw Exception('Erreur lors du chargement des catégories');
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  Future<List<ServiceModel>> getServicesByCategorie(String categorieId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/service?categorie=$categorieId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServiceModel.fromJson(json)).toList();
      }
      throw Exception('Erreur lors du chargement des services');
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }
}
