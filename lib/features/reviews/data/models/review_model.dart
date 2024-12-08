import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String id;
  final String serviceId;
  final String customerId;
  final String providerId;
  final String? bookingId;
  final double rating;
  final String comment;
  final List<String>? images;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ReviewModel({
    required this.id,
    required this.serviceId,
    required this.customerId,
    required this.providerId,
    this.bookingId,
    required this.rating,
    required this.comment,
    this.images,
    this.isVerified = false,
    required this.createdAt,
    this.updatedAt,
  });

  ReviewModel copyWith({
    double? rating,
    String? comment,
    List<String>? images,
    bool? isVerified,
    DateTime? updatedAt,
  }) {
    return ReviewModel(
      id: id,
      serviceId: serviceId,
      customerId: customerId,
      providerId: providerId,
      bookingId: bookingId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      images: images ?? this.images,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceId': serviceId,
      'customerId': customerId,
      'providerId': providerId,
      'bookingId': bookingId,
      'rating': rating,
      'comment': comment,
      'images': images,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      serviceId: json['serviceId'],
      customerId: json['customerId'],
      providerId: json['providerId'],
      bookingId: json['bookingId'],
      rating: json['rating'].toDouble(),
      comment: json['comment'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : null,
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        serviceId,
        customerId,
        providerId,
        bookingId,
        rating,
        comment,
        images,
        isVerified,
        createdAt,
        updatedAt,
      ];
}
