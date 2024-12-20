import '../domain/models/review.dart';

final List<Review> mockReviews = [
  Review(
    id: '1',
    userId: 'user1',
    userName: 'Kouassi Marie',
    userAvatar: 'https://randomuser.me/api/portraits/women/1.jpg',
    rating: 5.0,
    comment: 'Excellent travail ! Très professionnel et réactif. Je recommande vivement.',
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Review(
    id: '2',
    userId: 'user2',
    userName: 'Koné Ibrahim',
    userAvatar: 'https://randomuser.me/api/portraits/men/2.jpg',
    rating: 4.5,
    comment: 'Bon freelance, travail de qualité. Quelques retards dans la communication mais le résultat est satisfaisant.',
    date: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Review(
    id: '3',
    userId: 'user3',
    userName: 'Bamba Aminata',
    userAvatar: 'https://randomuser.me/api/portraits/women/3.jpg',
    rating: 5.0,
    comment: 'Une excellente expérience ! Le travail a été livré avant la deadline et la qualité est au rendez-vous.',
    date: DateTime.now().subtract(const Duration(days: 7)),
  ),
];
