import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final double? oldPrice;
  final String sellerId;
  final String sellerName;
  final String sellerAvatar;
  final List<String> images;
  final String categoryId;
  final bool isNew;
  final bool isAvailable;
  final DateTime createdAt;
  final int viewCount;
  final double rating;
  final int reviewCount;
  final String location;
  final List<String> tags;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.sellerId,
    required this.sellerName,
    required this.sellerAvatar,
    required this.images,
    required this.categoryId,
    this.isNew = true,
    this.isAvailable = true,
    required this.createdAt,
    this.viewCount = 0,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.location,
    this.tags = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      oldPrice: json['oldPrice'] != null ? (json['oldPrice'] as num).toDouble() : null,
      sellerId: json['sellerId'] as String,
      sellerName: json['sellerName'] as String,
      sellerAvatar: json['sellerAvatar'] as String,
      images: List<String>.from(json['images'] as List),
      categoryId: json['categoryId'] as String,
      isNew: json['isNew'] as bool? ?? true,
      isAvailable: json['isAvailable'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      viewCount: json['viewCount'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      location: json['location'] as String,
      tags: List<String>.from(json['tags'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'oldPrice': oldPrice,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'sellerAvatar': sellerAvatar,
      'images': images,
      'categoryId': categoryId,
      'isNew': isNew,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toIso8601String(),
      'viewCount': viewCount,
      'rating': rating,
      'reviewCount': reviewCount,
      'location': location,
      'tags': tags,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        oldPrice,
        sellerId,
        sellerName,
        sellerAvatar,
        images,
        categoryId,
        isNew,
        isAvailable,
        createdAt,
        viewCount,
        rating,
        reviewCount,
        location,
        tags,
      ];
}
