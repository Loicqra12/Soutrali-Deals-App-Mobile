import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/filter_service.dart';
import '../../data/freelancers_data.dart';
import '../../data/categories_data.dart';
import '../../domain/models/freelancer.dart';
import '../../domain/models/category.dart';
import '../widgets/freelancer_card.dart';
import '../widgets/advanced_filters.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';

class FreelancesPage extends StatefulWidget {
  final String? currentUserId;

  const FreelancesPage({
    super.key,
    this.currentUserId,
  });

  @override
  State<FreelancesPage> createState() => _FreelancesPageState();
}

class _FreelancesPageState extends State<FreelancesPage> {
  final ScrollController _scrollController = ScrollController();
  final FilterService _filterService = FilterService();
  final TextEditingController _searchController = TextEditingController();
  
  bool _showFloatingButton = false;
  bool _showFilters = false;
  List<Freelancer> _filteredFreelancers = [];
  Map<String, dynamic> _currentFilters = {};

  @override
  void initState() {
    super.initState();
    _filteredFreelancers = mockFreelancers;
    _scrollController.addListener(() {
      setState(() {
        _showFloatingButton = _scrollController.offset > 200;
      });
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onFiltersChanged(Map<String, dynamic> filters) {
    setState(() {
      _currentFilters = filters;
      _filteredFreelancers = _filterService.filterFreelancers(
        freelancers: mockFreelancers,
        filters: filters,
      );
    });
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredFreelancers = _filterService.filterFreelancers(
          freelancers: mockFreelancers,
          filters: _currentFilters,
        );
      } else {
        _filteredFreelancers = _filterService
            .filterFreelancers(
              freelancers: mockFreelancers,
              filters: _currentFilters,
            )
            .where((freelancer) =>
                freelancer.name.toLowerCase().contains(query.toLowerCase()) ||
                freelancer.profession.toLowerCase().contains(query.toLowerCase()) ||
                freelancer.skills.any((skill) =>
                    skill.toLowerCase().contains(query.toLowerCase())))
            .toList();
      }
    });
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      backgroundColor: const Color(0xFF27AE60),
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Freelances',
          style: TextStyle(color: Colors.white),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF27AE60), Color(0xFF1E8449)],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _showFilters ? Icons.filter_list_off : Icons.filter_list,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _showFilters = !_showFilters;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Rechercher un freelance...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onChanged: _onSearch,
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Catégories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: freelanceCategories.length,
            itemBuilder: (context, index) {
              final category = freelanceCategories[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentFilters = {
                        'category': category.name,
                      };
                      _onFiltersChanged(_currentFilters);
                    });
                  },
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconData(
                            int.parse('0xe${category.icon}', radix: 16),
                            fontFamily: 'MaterialIcons',
                          ),
                          size: 32,
                          color: const Color(0xFF27AE60),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFreelancersList() {
    if (_filteredFreelancers.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Aucun freelance trouvé',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Essayez de modifier vos filtres\nou votre recherche',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
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
              currentUserId: widget.currentUserId,
            );
          },
          childCount: _filteredFreelancers.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _filteredFreelancers = mockFreelancers;
              _currentFilters = {};
            });
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildSearchBar(),
                    if (_showFilters)
                      AdvancedFilters(
                        categories: freelanceCategories,
                        currentFilters: _currentFilters,
                        onFiltersChanged: _onFiltersChanged,
                      ),
                    _buildCategories(),
                  ],
                ),
              ),
              _buildFreelancersList(),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_showFloatingButton)
            FloatingActionButton(
              onPressed: _scrollToTop,
              mini: true,
              heroTag: 'scrollTop',
              backgroundColor: const Color(0xFF27AE60),
              child: const Icon(Icons.arrow_upward),
            ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            onPressed: () => context.go('/freelance/registration'),
            heroTag: 'register',
            backgroundColor: const Color(0xFF27AE60),
            label: const Text('Devenir freelance'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
