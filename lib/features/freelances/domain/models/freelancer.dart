class Freelancer {
  final String id;
  final String name;
  final String profession;
  final double rating;
  final String categoryId;
  final String subcategoryId;
  final String imageUrl;
  final String location;
  final double hourlyRate;
  final List<String> skills;

  const Freelancer({
    required this.id,
    required this.name,
    required this.profession,
    required this.rating,
    required this.categoryId,
    required this.subcategoryId,
    required this.imageUrl,
    required this.location,
    required this.hourlyRate,
    required this.skills,
  });
}
