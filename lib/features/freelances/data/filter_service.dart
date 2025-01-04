import 'package:flutter/material.dart';
import '../domain/models/freelancer.dart';

class FilterService {
  List<Freelancer> filterFreelancers({
    required List<Freelancer> freelancers,
    required Map<String, dynamic> filters,
  }) {
    List<Freelancer> filteredList = List.from(freelancers);

    // Filtre par catégorie
    if (filters['category'] != null) {
      filteredList = filteredList
          .where((freelancer) => freelancer.categoryId == filters['category'])
          .toList();
    }

    // Filtre par sous-catégorie
    if (filters['subcategory'] != null) {
      filteredList = filteredList
          .where((freelancer) => freelancer.subcategoryId == filters['subcategory'])
          .toList();
    }

    // Filtre par fourchette de prix
    if (filters['priceRange'] != null) {
      final RangeValues priceRange = filters['priceRange'];
      filteredList = filteredList
          .where((freelancer) =>
              freelancer.hourlyRate >= priceRange.start &&
              freelancer.hourlyRate <= priceRange.end)
          .toList();
    }

    // Filtre par note minimale
    if (filters['minRating'] != null) {
      final double minRating = filters['minRating'];
      filteredList = filteredList
          .where((freelancer) => freelancer.rating >= minRating)
          .toList();
    }

    // Filtre par disponibilité
    if (filters['availabilities'] != null) {
      final List<String> availabilities = filters['availabilities'];
      if (availabilities.isNotEmpty) {
        filteredList = filteredList
            .where((freelancer) => availabilities
                .any((availability) => freelancer.availability == availability))
            .toList();
      }
    }

    // Filtre par expérience
    if (filters['experience'] != null) {
      final String experience = filters['experience'];
      filteredList = filteredList
          .where((freelancer) => _matchesExperience(freelancer, experience))
          .toList();
    }

    // Tri
    if (filters['sortBy'] != null) {
      final String sortBy = filters['sortBy'];
      switch (sortBy) {
        case 'Prix (croissant)':
          filteredList.sort((a, b) => a.hourlyRate.compareTo(b.hourlyRate));
          break;
        case 'Prix (décroissant)':
          filteredList.sort((a, b) => b.hourlyRate.compareTo(a.hourlyRate));
          break;
        case 'Note (meilleure)':
          filteredList.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'Expérience':
          filteredList.sort((a, b) => b.yearsOfExperience.compareTo(a.yearsOfExperience));
          break;
        case 'Distance':
          // TODO: Implémenter le tri par distance
          break;
      }
    }

    return filteredList;
  }

  bool _matchesExperience(Freelancer freelancer, String experienceFilter) {
    final years = freelancer.yearsOfExperience;
    switch (experienceFilter) {
      case 'Débutant (0-2 ans)':
        return years <= 2;
      case 'Intermédiaire (2-5 ans)':
        return years > 2 && years <= 5;
      case 'Expérimenté (5-8 ans)':
        return years > 5 && years <= 8;
      case 'Expert (8+ ans)':
        return years > 8;
      default:
        return true;
    }
  }
}
