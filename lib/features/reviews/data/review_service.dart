import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/review.dart';

class ReviewService {
  static const String _reviewsKey = 'reviews';
  static ReviewService? _instance;
  final SharedPreferences _prefs;
  final StreamController<List<Review>> _reviewsController = StreamController<List<Review>>.broadcast();

  ReviewService._(this._prefs);

  static Future<ReviewService> getInstance() async {
    if (_instance == null) {
      final prefs = await SharedPreferences.getInstance();
      _instance = ReviewService._(prefs);
    }
    return _instance!;
  }

  Stream<List<Review>> get reviewsStream => _reviewsController.stream;

  Future<List<Review>> getFreelancerReviews(String freelancerId) async {
    final String? reviewsJson = _prefs.getString(_reviewsKey);
    if (reviewsJson == null) return [];

    final List<dynamic> reviewsList = json.decode(reviewsJson);
    return reviewsList
        .map((json) => Review(
              id: json['id'],
              freelancerId: json['freelancerId'],
              clientId: json['clientId'],
              clientName: json['clientName'],
              rating: json['rating'].toDouble(),
              comment: json['comment'],
              createdAt: DateTime.parse(json['createdAt']),
              images: List<String>.from(json['images']),
              isVerified: json['isVerified'],
              response: json['response'] != null
                  ? ReviewResponse(
                      id: json['response']['id'],
                      reviewId: json['response']['reviewId'],
                      freelancerId: json['response']['freelancerId'],
                      response: json['response']['response'],
                      createdAt: DateTime.parse(json['response']['createdAt']),
                    )
                  : null,
            ))
        .where((review) => review.freelancerId == freelancerId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<double> getFreelancerAverageRating(String freelancerId) async {
    final reviews = await getFreelancerReviews(freelancerId);
    if (reviews.isEmpty) return 0;
    final total = reviews.fold(0.0, (sum, review) => sum + review.rating);
    return total / reviews.length;
  }

  Future<Map<int, int>> getFreelancerRatingDistribution(String freelancerId) async {
    final reviews = await getFreelancerReviews(freelancerId);
    final distribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (final review in reviews) {
      distribution[review.rating.round()] = (distribution[review.rating.round()] ?? 0) + 1;
    }
    return distribution;
  }

  Future<void> addReview(Review review) async {
    final reviews = await _getAllReviews();
    reviews.add(review);
    await _saveReviews(reviews);
    _reviewsController.add(await getFreelancerReviews(review.freelancerId));
  }

  Future<void> addResponse(String reviewId, ReviewResponse response) async {
    final reviews = await _getAllReviews();
    final index = reviews.indexWhere((r) => r.id == reviewId);
    if (index >= 0) {
      reviews[index] = reviews[index].copyWith(response: response);
      await _saveReviews(reviews);
      _reviewsController.add(await getFreelancerReviews(response.freelancerId));
    }
  }

  Future<void> verifyReview(String reviewId) async {
    final reviews = await _getAllReviews();
    final index = reviews.indexWhere((r) => r.id == reviewId);
    if (index >= 0) {
      reviews[index] = reviews[index].copyWith(isVerified: true);
      await _saveReviews(reviews);
      _reviewsController.add(await getFreelancerReviews(reviews[index].freelancerId));
    }
  }

  Future<List<Review>> _getAllReviews() async {
    final String? reviewsJson = _prefs.getString(_reviewsKey);
    if (reviewsJson == null) return [];

    final List<dynamic> reviewsList = json.decode(reviewsJson);
    return reviewsList.map((json) => Review(
          id: json['id'],
          freelancerId: json['freelancerId'],
          clientId: json['clientId'],
          clientName: json['clientName'],
          rating: json['rating'].toDouble(),
          comment: json['comment'],
          createdAt: DateTime.parse(json['createdAt']),
          images: List<String>.from(json['images']),
          isVerified: json['isVerified'],
          response: json['response'] != null
              ? ReviewResponse(
                  id: json['response']['id'],
                  reviewId: json['response']['reviewId'],
                  freelancerId: json['response']['freelancerId'],
                  response: json['response']['response'],
                  createdAt: DateTime.parse(json['response']['createdAt']),
                )
              : null,
        )).toList();
  }

  Future<void> _saveReviews(List<Review> reviews) async {
    final List<Map<String, dynamic>> reviewsJson = reviews.map((review) => {
          'id': review.id,
          'freelancerId': review.freelancerId,
          'clientId': review.clientId,
          'clientName': review.clientName,
          'rating': review.rating,
          'comment': review.comment,
          'createdAt': review.createdAt.toIso8601String(),
          'images': review.images,
          'isVerified': review.isVerified,
          'response': review.response != null
              ? {
                  'id': review.response!.id,
                  'reviewId': review.response!.reviewId,
                  'freelancerId': review.response!.freelancerId,
                  'response': review.response!.response,
                  'createdAt': review.response!.createdAt.toIso8601String(),
                }
              : null,
        }).toList();

    await _prefs.setString(_reviewsKey, json.encode(reviewsJson));
  }

  void dispose() {
    _reviewsController.close();
  }
}
