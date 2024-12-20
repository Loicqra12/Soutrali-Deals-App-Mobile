import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../data/categories_data.dart';
import '../../data/freelancers_data.dart';
import '../../domain/models/category.dart';
import '../../domain/models/freelancer.dart';
import '../theme/freelance_theme.dart';
import '../widgets/category_card.dart';
import '../widgets/freelancer_card.dart';
import '../widgets/subcategory_chip.dart';

class FreelancesPage extends StatefulWidget {
  const FreelancesPage({Key? key}) : super(key: key);

  @override
  State<FreelancesPage> createState() => _FreelancesPageState();
}

class _FreelancesPageState extends State<FreelancesPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late final AnimationController _animationController;
  FreelanceCategory? _selectedCategory;
  FreelanceSubcategory? _selectedSubcategory;
  String _searchQuery = '';
  bool _showFilters = false;
  RangeValues _priceRange = const RangeValues(0, 50000);
  double _minRating = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(FreelanceCategory category) {
    setState(() {
      if (_selectedCategory?.id == category.id) {
        _selectedCategory = null;
        _selectedSubcategory = null;
        _animationController.reverse();
      } else {
        _selectedCategory = category;
        _selectedSubcategory = null;
        _animationController.forward();
      }
    });
  }

  void _selectSubcategory(FreelanceSubcategory subcategory) {
    setState(() {
      if (_selectedSubcategory?.id == subcategory.id) {
        _selectedSubcategory = null;
      } else {
        _selectedSubcategory = subcategory;
      }
    });
  }

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = null;
      _selectedSubcategory = null;
      _priceRange = const RangeValues(0, 50000);
      _minRating = 0;
      _searchController.clear();
      _searchQuery = '';
    });
  }

  List<Freelancer> get _filteredFreelancers {
    return mockFreelancers.where((freelancer) {
      bool matchesCategory = _selectedCategory == null || 
                           freelancer.categoryId == _selectedCategory!.id;
      bool matchesSubcategory = _selectedSubcategory == null || 
                               freelancer.subcategoryId == _selectedSubcategory!.id;
      bool matchesSearch = _searchQuery.isEmpty ||
                          freelancer.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          freelancer.profession.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          freelancer.skills.any((skill) => 
                            skill.toLowerCase().contains(_searchQuery.toLowerCase()));
      bool matchesPriceRange = freelancer.hourlyRate >= _priceRange.start &&
                              freelancer.hourlyRate <= _priceRange.end;
      bool matchesRating = freelancer.rating >= _minRating;
      
      return matchesCategory && matchesSubcategory && matchesSearch && 
             matchesPriceRange && matchesRating;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: FreelanceTheme.primaryColor.withOpacity(0.1),
                        child: Icon(Icons.person, color: FreelanceTheme.primaryColor),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'SOUTRALI DEALS',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () => context.push('/notifications'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    decoration: FreelanceTheme.searchInputDecoration.copyWith(
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_showFilters || _selectedCategory != null || _minRating > 0 || 
                              _priceRange != const RangeValues(0, 50000))
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _resetFilters,
                              color: FreelanceTheme.primaryColor,
                            ),
                          IconButton(
                            icon: Icon(
                              _showFilters ? Icons.tune_outlined : Icons.tune,
                              color: _showFilters ? FreelanceTheme.accentColor : FreelanceTheme.primaryColor,
                            ),
                            onPressed: _toggleFilters,
                          ),
                        ],
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                  if (_showFilters) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Filtres',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Tarif horaire (FCFA)',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          RangeSlider(
                            values: _priceRange,
                            min: 0,
                            max: 50000,
                            divisions: 50,
                            labels: RangeLabels(
                              '${_priceRange.start.round()} FCFA',
                              '${_priceRange.end.round()} FCFA',
                            ),
                            onChanged: (values) {
                              setState(() {
                                _priceRange = values;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Note minimale',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Slider(
                            value: _minRating,
                            min: 0,
                            max: 5,
                            divisions: 10,
                            label: _minRating == 0 
                                ? 'Tous' 
                                : '${_minRating.toStringAsFixed(1)} étoiles',
                            onChanged: (value) {
                              setState(() {
                                _minRating = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Top catégories',
                                  style: FreelanceTheme.headingStyle,
                                ),
                              ),
                              SizedBox(
                                height: FreelanceTheme.categoryCardHeight,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  itemCount: freelanceCategories.length,
                                  itemBuilder: (context, index) {
                                    final category = freelanceCategories[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: CategoryCard(
                                        category: category,
                                        isSelected: _selectedCategory?.id == category.id,
                                        onTap: () => _selectCategory(category),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (_selectedCategory != null)
                                SizeTransition(
                                  sizeFactor: _animationController,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 24),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(
                                          'Sous-catégories de ${_selectedCategory!.name}',
                                          style: FreelanceTheme.subheadingStyle,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        height: 40,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          itemCount: _selectedCategory!.subcategories.length,
                                          itemBuilder: (context, index) {
                                            final subcategory = _selectedCategory!.subcategories[index];
                                            return SubcategoryChip(
                                              subcategory: subcategory,
                                              isSelected: _selectedSubcategory?.id == subcategory.id,
                                              onTap: () => _selectSubcategory(subcategory),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 24),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Freelancers ${_selectedCategory != null ? 'en ${_selectedCategory!.name}' : ''} ${_selectedSubcategory != null ? '- ${_selectedSubcategory!.name}' : ''}',
                                      style: FreelanceTheme.headingStyle,
                                    ),
                                    Text(
                                      '${_filteredFreelancers.length} trouvés',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final freelancer = _filteredFreelancers[index];
                                return FreelancerCard(
                                  freelancer: freelancer,
                                  onTap: () => context.push('/freelancer/${freelancer.id}'),
                                );
                              },
                              childCount: _filteredFreelancers.length,
                            ),
                          ),
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.only(bottom: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: FreelanceTheme.primaryColor,
            ),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        onSelected: (bool selected) {
          // TODO: Implement filter logic
        },
        backgroundColor: Colors.white,
        selectedColor: FreelanceTheme.primaryColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
      ),
    );
  }
}
