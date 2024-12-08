import 'package:equatable/equatable.dart';

class ServiceModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final String providerId;
  final double price;
  final String? imageUrl;
  final List<String>? gallery;
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.providerId,
    required this.price,
    this.imageUrl,
    this.gallery,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isAvailable = true,
    this.metadata,
    required this.createdAt,
    this.updatedAt,
  });

  ServiceModel copyWith({
    String? title,
    String? description,
    String? categoryId,
    String? providerId,
    double? price,
    String? imageUrl,
    List<String>? gallery,
    double? rating,
    int? reviewCount,
    bool? isAvailable,
    Map<String, dynamic>? metadata,
    DateTime? updatedAt,
  }) {
    return ServiceModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      providerId: providerId ?? this.providerId,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      gallery: gallery ?? this.gallery,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isAvailable: isAvailable ?? this.isAvailable,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'providerId': providerId,
      'price': price,
      'imageUrl': imageUrl,
      'gallery': gallery,
      'rating': rating,
      'reviewCount': reviewCount,
      'isAvailable': isAvailable,
      'metadata': metadata,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      categoryId: json['categoryId'],
      providerId: json['providerId'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      gallery: json['gallery'] != null
          ? List<String>.from(json['gallery'])
          : null,
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      isAvailable: json['isAvailable'] ?? true,
      metadata: json['metadata'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        categoryId,
        providerId,
        price,
        imageUrl,
        gallery,
        rating,
        reviewCount,
        isAvailable,
        metadata,
        createdAt,
        updatedAt,
      ];
}
