import 'package:flutter/material.dart';

enum SortOption {
  newest,
  priceHighToLow,
  priceLowToHigh,
  popularity,
  rating
}

class FilterBar extends StatelessWidget {
  final SortOption selectedSort;
  final Function(SortOption) onSortChanged;
  final VoidCallback onFilterTap;

  const FilterBar({
    Key? key,
    required this.selectedSort,
    required this.onSortChanged,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<SortOption>(
              value: selectedSort,
              isExpanded: true,
              underline: const SizedBox(),
              icon: const Icon(Icons.sort),
              items: SortOption.values.map((SortOption option) {
                return DropdownMenuItem<SortOption>(
                  value: option,
                  child: Text(
                    _getSortOptionText(option),
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (SortOption? newValue) {
                if (newValue != null) {
                  onSortChanged(newValue);
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: onFilterTap,
            tooltip: 'Plus de filtres',
          ),
        ],
      ),
    );
  }

  String _getSortOptionText(SortOption option) {
    switch (option) {
      case SortOption.newest:
        return 'Plus récents';
      case SortOption.priceHighToLow:
        return 'Prix décroissant';
      case SortOption.priceLowToHigh:
        return 'Prix croissant';
      case SortOption.popularity:
        return 'Popularité';
      case SortOption.rating:
        return 'Note';
    }
  }
}
