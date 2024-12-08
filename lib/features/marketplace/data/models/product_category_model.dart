import 'package:equatable/equatable.dart';

class ProductCategory extends Equatable {
  final String id;
  final String name;
  final String icon;
  final String? description;
  final int itemCount;
  final bool isActive;

  const ProductCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.description,
    this.itemCount = 0,
    this.isActive = true,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String?,
      itemCount: json['itemCount'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'description': description,
      'itemCount': itemCount,
      'isActive': isActive,
    };
  }

  @override
  List<Object?> get props => [id, name, icon, description, itemCount, isActive];
}

// Catégories prédéfinies
final List<ProductCategory> predefinedCategories = [
  const ProductCategory(
    id: 'auto',
    name: 'Automobile & Moto',
    icon: 'assets/icons/categories/auto.svg',
  ),
  const ProductCategory(
    id: 'real_estate',
    name: 'Immobilier',
    icon: 'assets/icons/categories/real_estate.svg',
  ),
  const ProductCategory(
    id: 'electronics',
    name: 'Électronique',
    icon: 'assets/icons/categories/electronics.svg',
  ),
  const ProductCategory(
    id: 'fashion',
    name: 'Mode',
    icon: 'assets/icons/categories/fashion.svg',
  ),
];
