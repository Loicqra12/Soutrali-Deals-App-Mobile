import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/review_service.dart';

class ReviewServiceProvider extends InheritedWidget {
  final ReviewService reviewService;

  const ReviewServiceProvider({
    super.key,
    required super.child,
    required this.reviewService,
  });

  static ReviewService of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ReviewServiceProvider>();
    if (provider == null) {
      throw Exception('ReviewServiceProvider not found in context');
    }
    return provider.reviewService;
  }

  @override
  bool updateShouldNotify(ReviewServiceProvider oldWidget) {
    return reviewService != oldWidget.reviewService;
  }

  static Future<ReviewServiceProvider> create({
    required Widget child,
  }) async {
    final reviewService = await ReviewService.getInstance();
    return ReviewServiceProvider(
      reviewService: reviewService,
      child: child,
    );
  }
}
