class Favorite {
  final String id;
  final String userId;
  final String freelancerId;
  final DateTime createdAt;

  const Favorite({
    required this.id,
    required this.userId,
    required this.freelancerId,
    required this.createdAt,
  });

  factory Favorite.create({
    required String userId,
    required String freelancerId,
  }) {
    return Favorite(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      freelancerId: freelancerId,
      createdAt: DateTime.now(),
    );
  }
}
