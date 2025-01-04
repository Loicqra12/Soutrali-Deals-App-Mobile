import 'package:flutter/material.dart';
import '../../data/review_service.dart';
import '../../domain/models/review.dart';
import '../widgets/review_card.dart';
import '../widgets/rating_distribution.dart';
import '../widgets/add_review_dialog.dart';

class ReviewPage extends StatefulWidget {
  final String freelancerId;
  final String currentUserId;
  final ReviewService reviewService;

  const ReviewPage({
    super.key,
    required this.freelancerId,
    required this.currentUserId,
    required this.reviewService,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<Review> _reviews = [];
  double _averageRating = 0;
  Map<int, int> _ratingDistribution = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReviews();
    widget.reviewService.reviewsStream.listen((reviews) {
      if (mounted) {
        _loadReviews();
      }
    });
  }

  Future<void> _loadReviews() async {
    setState(() => _isLoading = true);
    try {
      final reviews = await widget.reviewService.getFreelancerReviews(widget.freelancerId);
      final averageRating = await widget.reviewService.getFreelancerAverageRating(widget.freelancerId);
      final ratingDistribution = await widget.reviewService.getFreelancerRatingDistribution(widget.freelancerId);
      
      if (mounted) {
        setState(() {
          _reviews = reviews;
          _averageRating = averageRating;
          _ratingDistribution = ratingDistribution;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors du chargement des avis'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _showAddReviewDialog() async {
    final hasExistingReview = _reviews.any((review) => review.clientId == widget.currentUserId);
    if (hasExistingReview) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vous avez déjà laissé un avis'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    if (mounted) {
      await showDialog(
        context: context,
        builder: (context) => AddReviewDialog(
          freelancerId: widget.freelancerId,
          clientId: widget.currentUserId,
          reviewService: widget.reviewService,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avis et évaluations'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              _averageRating.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < _averageRating.floor()
                                          ? Icons.star
                                          : index < _averageRating
                                              ? Icons.star_half
                                              : Icons.star_border,
                                      color: Colors.amber,
                                      size: 20,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_reviews.length} avis',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        RatingDistribution(distribution: _ratingDistribution),
                        const SizedBox(height: 16),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
                _reviews.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.rate_review_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Aucun avis pour le moment',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Soyez le premier à donner votre avis',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final review = _reviews[index];
                            return ReviewCard(
                              review: review,
                              isFreelancer: widget.currentUserId == widget.freelancerId,
                              reviewService: widget.reviewService,
                            );
                          },
                          childCount: _reviews.length,
                        ),
                      ),
              ],
            ),
      floatingActionButton: widget.currentUserId != widget.freelancerId
          ? FloatingActionButton.extended(
              onPressed: _showAddReviewDialog,
              icon: const Icon(Icons.rate_review),
              label: const Text('Donner mon avis'),
            )
          : null,
    );
  }
}
