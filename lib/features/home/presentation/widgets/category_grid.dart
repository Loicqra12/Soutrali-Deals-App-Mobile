import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'icon': Icons.plumbing,
        'name': 'Plomberie',
        'color': const Color(0xFF27AE60),
      },
      {
        'icon': Icons.electrical_services,
        'name': 'Électricité',
        'color': const Color(0xFF2D9CDB),
      },
      {
        'icon': Icons.cleaning_services,
        'name': 'Nettoyage',
        'color': const Color(0xFF9B51E0),
      },
      {
        'icon': Icons.build,
        'name': 'Bricolage',
        'color': const Color(0xFFF2994A),
      },
      {
        'icon': Icons.local_shipping,
        'name': 'Transport',
        'color': const Color(0xFFEB5757),
      },
      {
        'icon': Icons.computer,
        'name': 'Informatique',
        'color': const Color(0xFF219653),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Catégories',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to categories page
                },
                child: const Text('Voir tout'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildCategoryItem(
                context,
                icon: category['icon'],
                name: category['name'],
                color: category['color'],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context, {
    required IconData icon,
    required String name,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to category page
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
