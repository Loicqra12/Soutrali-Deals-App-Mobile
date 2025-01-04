class Review {
  final String id;
  final String freelancerId;
  final String clientId;
  final String clientName;
  final double rating;
  final String comment;
  final DateTime createdAt;
  final List<String> images;
  final bool isVerified;
  final ReviewResponse? response;

  const Review({
    required this.id,
    required this.freelancerId,
    required this.clientId,
    required this.clientName,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.images = const [],
    this.isVerified = false,
    this.response,
  });

  factory Review.create({
    required String freelancerId,
    required String clientId,
    required String clientName,
    required double rating,
    required String comment,
    List<String> images = const [],
  }) {
    return Review(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      freelancerId: freelancerId,
      clientId: clientId,
      clientName: clientName,
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
      images: images,
      isVerified: false,
    );
  }

  Review copyWith({
    String? id,
    String? freelancerId,
    String? clientId,
    String? clientName,
    double? rating,
    String? comment,
    DateTime? createdAt,
    List<String>? images,
    bool? isVerified,
    ReviewResponse? response,
  }) {
    return Review(
      id: id ?? this.id,
      freelancerId: freelancerId ?? this.freelancerId,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
      isVerified: isVerified ?? this.isVerified,
      response: response ?? this.response,
    );
  }
}

class ReviewResponse {
  final String id;
  final String reviewId;
  final String freelancerId;
  final String response;
  final DateTime createdAt;

  const ReviewResponse({
    required this.id,
    required this.reviewId,
    required this.freelancerId,
    required this.response,
    required this.createdAt,
  });

  factory ReviewResponse.create({
    required String reviewId,
    required String freelancerId,
    required String response,
  }) {
    return ReviewResponse(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      reviewId: reviewId,
      freelancerId: freelancerId,
      response: response,
      createdAt: DateTime.now(),
    );
  }
}
