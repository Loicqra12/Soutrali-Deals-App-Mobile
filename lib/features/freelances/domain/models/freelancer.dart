class Freelancer {
  final String id;
  final String name;
  final String profession;
  final String categoryId;
  final String subcategoryId;
  final double rating;
  final String location;
  final double hourlyRate;
  final List<String> skills;
  final String availability;
  final int yearsOfExperience;
  final String imageUrl;

  const Freelancer({
    required this.id,
    required this.name,
    required this.profession,
    required this.categoryId,
    required this.subcategoryId,
    required this.rating,
    required this.location,
    required this.hourlyRate,
    required this.skills,
    required this.availability,
    required this.yearsOfExperience,
    required this.imageUrl,
  });
}
