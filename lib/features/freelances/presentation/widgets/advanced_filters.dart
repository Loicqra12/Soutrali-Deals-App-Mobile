import 'package:flutter/material.dart';
import '../../domain/models/category.dart';
import 'package:intl/intl.dart';

class AdvancedFilters extends StatefulWidget {
  final List<FreelanceCategory> categories;
  final Function(Map<String, dynamic>) onFiltersChanged;
  final Map<String, dynamic> currentFilters;

  const AdvancedFilters({
    super.key,
    required this.categories,
    required this.onFiltersChanged,
    required this.currentFilters,
  });

  @override
  State<AdvancedFilters> createState() => _AdvancedFiltersState();
}

class _AdvancedFiltersState extends State<AdvancedFilters> {
  late RangeValues _priceRange;
  late double _minRating;
  late String? _selectedCategory;
  late String? _selectedSubcategory;
  late List<String> _selectedAvailabilities;
  late String _selectedExperience;
  late String _sortBy;

  final List<String> _availabilities = [
    'Disponible maintenant',
    'Cette semaine',
    'Ce mois',
    'Sur rendez-vous',
  ];

  final List<String> _experiences = [
    'Débutant (0-2 ans)',
    'Intermédiaire (2-5 ans)',
    'Expérimenté (5-8 ans)',
    'Expert (8+ ans)',
  ];

  final List<String> _sortOptions = [
    'Prix (croissant)',
    'Prix (décroissant)',
    'Note (meilleure)',
    'Expérience',
    'Distance',
  ];

  @override
  void initState() {
    super.initState();
    _initializeFilters();
  }

  void _initializeFilters() {
    _priceRange = widget.currentFilters['priceRange'] ?? const RangeValues(0, 50000);
    _minRating = widget.currentFilters['minRating'] ?? 0.0;
    _selectedCategory = widget.currentFilters['category'];
    _selectedSubcategory = widget.currentFilters['subcategory'];
    _selectedAvailabilities = List<String>.from(widget.currentFilters['availabilities'] ?? []);
    _selectedExperience = widget.currentFilters['experience'] ?? _experiences[0];
    _sortBy = widget.currentFilters['sortBy'] ?? _sortOptions[0];
  }

  void _updateFilters() {
    widget.onFiltersChanged({
      'priceRange': _priceRange,
      'minRating': _minRating,
      'category': _selectedCategory,
      'subcategory': _selectedSubcategory,
      'availabilities': _selectedAvailabilities,
      'experience': _selectedExperience,
      'sortBy': _sortBy,
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'fr_CI',
      symbol: 'FCFA',
      decimalDigits: 0,
    );

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filtres avancés',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _priceRange = const RangeValues(0, 50000);
                      _minRating = 0;
                      _selectedCategory = null;
                      _selectedSubcategory = null;
                      _selectedAvailabilities = [];
                      _selectedExperience = _experiences[0];
                      _sortBy = _sortOptions[0];
                    });
                    _updateFilters();
                  },
                  child: const Text('Réinitialiser'),
                ),
              ],
            ),
            const Divider(),

            // Catégories
            const Text(
              'Catégorie',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              hint: const Text('Sélectionner une catégorie'),
              items: widget.categories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                  _selectedSubcategory = null;
                });
                _updateFilters();
              },
            ),
            const SizedBox(height: 16),

            // Sous-catégories
            if (_selectedCategory != null) ...[
              const Text(
                'Sous-catégorie',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedSubcategory,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                hint: const Text('Sélectionner une sous-catégorie'),
                items: widget.categories
                    .firstWhere((cat) => cat.id == _selectedCategory)
                    .subcategories
                    .map((subcategory) {
                  return DropdownMenuItem(
                    value: subcategory.id,
                    child: Text(subcategory.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSubcategory = value;
                  });
                  _updateFilters();
                },
              ),
              const SizedBox(height: 16),
            ],

            // Fourchette de prix
            const Text(
              'Fourchette de prix',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(currencyFormat.format(_priceRange.start)),
                Text(currencyFormat.format(_priceRange.end)),
              ],
            ),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 50000,
              divisions: 50,
              labels: RangeLabels(
                currencyFormat.format(_priceRange.start),
                currencyFormat.format(_priceRange.end),
              ),
              onChanged: (values) {
                setState(() {
                  _priceRange = values;
                });
                _updateFilters();
              },
            ),
            const SizedBox(height: 16),

            // Note minimale
            const Text(
              'Note minimale',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Slider(
              value: _minRating,
              min: 0,
              max: 5,
              divisions: 10,
              label: _minRating.toString(),
              onChanged: (value) {
                setState(() {
                  _minRating = value;
                });
                _updateFilters();
              },
            ),
            const SizedBox(height: 16),

            // Disponibilité
            const Text(
              'Disponibilité',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availabilities.map((availability) {
                final isSelected = _selectedAvailabilities.contains(availability);
                return FilterChip(
                  label: Text(availability),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedAvailabilities.add(availability);
                      } else {
                        _selectedAvailabilities.remove(availability);
                      }
                    });
                    _updateFilters();
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Expérience
            const Text(
              'Expérience',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedExperience,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              items: _experiences.map((experience) {
                return DropdownMenuItem(
                  value: experience,
                  child: Text(experience),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedExperience = value!;
                });
                _updateFilters();
              },
            ),
            const SizedBox(height: 16),

            // Tri
            const Text(
              'Trier par',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _sortBy,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              items: _sortOptions.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _sortBy = value!;
                });
                _updateFilters();
              },
            ),
          ],
        ),
      ),
    );
  }
}
