import 'package:flutter/material.dart';
import '../../data/models/service_group.dart';

class ServiceCategoryScreen extends StatefulWidget {
  final ServiceCategory category;

  const ServiceCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<ServiceCategoryScreen> createState() => _ServiceCategoryScreenState();
}

class _ServiceCategoryScreenState extends State<ServiceCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFiltering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          IconButton(
            icon: Icon(
              _isFiltering ? Icons.filter_list_off : Icons.filter_list,
            ),
            onPressed: () {
              setState(() {
                _isFiltering = !_isFiltering;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un service...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              onChanged: (value) {
                setState(() {
                  // TODO: Implement search
                });
              },
            ),
          ),
          if (_isFiltering) _buildFilterSection(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.category.subCategories.length,
              itemBuilder: (context, index) {
                final subCategory = widget.category.subCategories[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      subCategory.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          subCategory.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            Chip(
                              label: const Text('Disponible'),
                              backgroundColor: Colors.green[100],
                              labelStyle: TextStyle(
                                color: Colors.green[900],
                              ),
                            ),
                            Chip(
                              label: const Text('Pro'),
                              backgroundColor: Colors.blue[100],
                              labelStyle: TextStyle(
                                color: Colors.blue[900],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Détails de ${subCategory.name} à venir...'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filtres',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilterChip(
                label: const Text('Disponible maintenant'),
                selected: false,
                onSelected: (selected) {
                  // TODO: Implement filter
                },
              ),
              FilterChip(
                label: const Text('Professionnel'),
                selected: false,
                onSelected: (selected) {
                  // TODO: Implement filter
                },
              ),
              FilterChip(
                label: const Text('À proximité'),
                selected: false,
                onSelected: (selected) {
                  // TODO: Implement filter
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
