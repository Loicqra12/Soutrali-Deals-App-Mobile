import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'icon': Icons.home_repair_service,
        'label': 'Services',
        'color': const Color(0xFF27AE60),
      },
      {
        'icon': Icons.shopping_cart,
        'label': 'Produits',
        'color': const Color(0xFF2D9CDB),
      },
      {
        'icon': Icons.calendar_today,
        'label': 'Réservations',
        'color': const Color(0xFF9B51E0),
      },
      {
        'icon': Icons.local_offer,
        'label': 'Offres',
        'color': const Color(0xFFF2994A),
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Accès rapide',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: actions.map((action) {
              return _buildActionItem(
                context,
                icon: action['icon'],
                label: action['label'],
                color: action['color'],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        // TODO: Implement navigation
      },
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
