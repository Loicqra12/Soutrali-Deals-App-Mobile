class HomeServiceCategory {
  final String id;
  final String name;
  final String icon;
  final List<HomeServiceGroup> groups;

  HomeServiceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.groups,
  });
}

class HomeServiceGroup {
  final String id;
  final String name;
  final String icon;
  final List<HomeServiceSubCategory> categories;

  HomeServiceGroup({
    required this.id,
    required this.name,
    required this.icon,
    required this.categories,
  });
}

class HomeServiceSubCategory {
  final String id;
  final String name;
  final String description;

  HomeServiceSubCategory({
   required this.id,
    required this.name,
    required this.description,
  });
}
