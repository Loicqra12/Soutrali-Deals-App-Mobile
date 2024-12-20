import 'package:flutter/material.dart';
import '../../domain/models/category.dart';
import '../theme/freelance_theme.dart';

class SubcategoryChip extends StatelessWidget {
  final FreelanceSubcategory subcategory;
  final bool isSelected;
  final VoidCallback onTap;

  const SubcategoryChip({
    Key? key,
    required this.subcategory,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? FreelanceTheme.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.grey[300]!,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: FreelanceTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  subcategory.name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
