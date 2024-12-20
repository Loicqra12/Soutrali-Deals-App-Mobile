class FreelanceCategory {
  final String id;
  final String name;
  final String icon;
  final List<FreelanceSubcategory> subcategories;

  const FreelanceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.subcategories,
  });
}

class FreelanceSubcategory {
  final String id;
  final String name;

  const FreelanceSubcategory({
    required this.id,
    required this.name,
  });
}
