import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues _priceRange = const RangeValues(0, 1000000);
  String _selectedCategory = 'Tous';
  String _selectedSubCategory = 'Tous';
  String _condition = 'Tous';
  String _location = 'Tous';
  double _minRating = 0;

  final Map<String, List<String>> _categories = {
    'Mode': [
      'Vêtements Homme',
      'Vêtements Femme',
      'Chaussures',
      'Accessoires',
      'Montres & Bijoux',
      'Sacs',
    ],
    'Électronique': [
      'Smartphones',
      'Ordinateurs',
      'Tablettes',
      'TV & Home Cinéma',
      'Audio',
      'Accessoires',
    ],
    'Maison': [
      'Meubles',
      'Décoration',
      'Électroménager',
      'Jardin',
      'Bricolage',
      'Linge de maison',
    ],
    'Auto & Moto': [
      'Voitures',
      'Motos',
      'Pièces détachées',
      'Accessoires auto',
      'Équipement moto',
      'Entretien',
    ],
    'Immobilier': [
      'Appartements',
      'Maisons',
      'Terrains',
      'Bureaux',
      'Locations',
      'Colocation',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Filtres',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _priceRange = const RangeValues(0, 1000000);
                _selectedCategory = 'Tous';
                _selectedSubCategory = 'Tous';
                _condition = 'Tous';
                _location = 'Tous';
                _minRating = 0;
              });
            },
            child: const Text(
              'Réinitialiser',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Prix
          _buildSection(
            'Prix',
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_priceRange.start.round()} FCFA',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_priceRange.end.round()} FCFA',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 1000000,
                  divisions: 100,
                  activeColor: const Color(0xFF27AE60),
                  labels: RangeLabels(
                    '${_priceRange.start.round()} FCFA',
                    '${_priceRange.end.round()} FCFA',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
                ),
              ],
            ),
          ),

          // Catégories
          _buildSection(
            'Catégorie',
            Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: 'Tous',
                      child: Text('Toutes les catégories'),
                    ),
                    ..._categories.keys.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                      _selectedSubCategory = 'Tous';
                    });
                  },
                ),
                if (_selectedCategory != 'Tous') ...[
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedSubCategory,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'Tous',
                        child: Text('Toutes les sous-catégories'),
                      ),
                      ...(_categories[_selectedCategory] ?? []).map((subCategory) {
                        return DropdownMenuItem(
                          value: subCategory,
                          child: Text(subCategory),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedSubCategory = value!;
                      });
                    },
                  ),
                ],
              ],
            ),
          ),

          // État
          _buildSection(
            'État',
            Wrap(
              spacing: 8,
              children: [
                _buildChoiceChip('Tous', _condition == 'Tous', (selected) {
                  setState(() => _condition = 'Tous');
                }),
                _buildChoiceChip('Neuf', _condition == 'Neuf', (selected) {
                  setState(() => _condition = 'Neuf');
                }),
                _buildChoiceChip('Occasion', _condition == 'Occasion', (selected) {
                  setState(() => _condition = 'Occasion');
                }),
              ],
            ),
          ),

          // Localisation
          _buildSection(
            'Localisation',
            DropdownButtonFormField<String>(
              value: _location,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: [
                'Tous',
                'Abidjan',
                'Bouaké',
                'Yamoussoukro',
                'San Pedro',
                'Korhogo'
              ].map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _location = value!;
                });
              },
            ),
          ),

          // Note minimale du vendeur
          _buildSection(
            'Note minimale du vendeur',
            Column(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _minRating
                            ? Icons.star
                            : Icons.star_border,
                        color: const Color(0xFF27AE60),
                      ),
                      onPressed: () {
                        setState(() {
                          _minRating = index + 1.0;
                        });
                      },
                    );
                  }),
                ),
                Text(
                  '${_minRating.round()} étoile${_minRating > 1 ? 's' : ''} minimum',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Appliquer les filtres
            context.pop({
              'priceRange': _priceRange,
              'category': _selectedCategory,
              'subCategory': _selectedSubCategory,
              'condition': _condition,
              'location': _location,
              'minRating': _minRating,
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF27AE60),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Appliquer les filtres',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        content,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildChoiceChip(String label, bool selected, Function(bool) onSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: const Color(0xFF27AE60),
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
      ),
    );
  }
}
